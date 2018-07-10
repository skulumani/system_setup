push @generated_exts, 'cb', 'cb2', 'spl', 'nav', 'snm', 'todo', 'nmo';
push @generated_exts, 'brf', 'nlg', 'nlo', 'nls', 'synctex.gz', 'run.xml';
push @generated_exts, 'fot', 'synctex.gz(busy)', 'bbl', 'blg', 'fdb_latexmk';

push @generated_exts, 'glo', 'gls', 'glg', 'fls';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'glg-abr', 'glo-abr', 'gls-abr';
push @generated_exts, 'slg', 'slo', 'sls';
push @generated_exts, 'dvi', 'aux';

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

add_cus_dep('aux', 'glstex', 0, 'run_bib2gls');
push @file_not_found, '^Package .* No file `([^\\\']*)\\\'';

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

sub run_bib2gls {
  if ( $silent ) {
    my $ret = system "bib2gls --silent --group '$_[0]'";
  } else {
    my $ret = system "bib2gls --group '$_[0]'";
  };
  my ($base, $path) = fileparse( $_[0] );
  if ($path && -e "$base.glstex") {
    rename "$base.glstex", "$path$base.glstex";
  }
  # Analyze log file.
  local *LOG;
  $LOG = "$_[0].glg";
  if (!$ret && -e $LOG) {
    open LOG, "<$LOG";
    while (<LOG>) {
      if (/^Reading (.*\.bib)\s$/) {
        rdb_ensure_file( $rule, $1 );
      }
    }
    close LOG;
  }
  return $ret;
}

$clean_ext .= '%R.ist %R.xdy';

$pdf_mode = 1;
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -shell-escape';
#$pdflatex = 'xelatex -file-line-error -shell-escape -synctex=1';
#$pdflatex = 'lualatex --interaction=nonstopmode --shell-escape --synctex=1';

# Adapted from http://tex.stackexchange.com/a/145878/26980
# Add a few files to cleanup
push @generated_exts, 'figlist', 'ist', 'makefile', 'unq';
# On the initial run, %tikzexternalflag is set to an empty list (when
# it reads this .latexmkrc).
#
# %tikzexternalflag is then set after successfully running make.

our %tikzexternalflag = ();

$pdflatex = 'internal tikzpdflatex -shell-escape -synctex=1 %O %S %B';

sub tikzpdflatex {
    our %externalflag;
    my $n = scalar(@_);
    my @args = @_[0 .. $n - 2];
    my $base = $_[$n - 1];

    system 'pdflatex', @args;
    # Exit with error on failure
    if ($? != 0) {
        return $?
    }
    if ( !defined $externalflag->{$base} ) {
        $externalflag->{$base} = 1;
        if ( -e "$base.makefile" ) {
            system ("$make -j4 -f $base.makefile");
        }
    }
    return $?;
}
