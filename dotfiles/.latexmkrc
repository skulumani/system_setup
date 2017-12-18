push @generated_exts, 'cb', 'cb2', 'spl', 'nav', 'snm', 'todo', 'nmo';
push @generated_exts, 'brf', 'nlg', 'nlo', 'nls', 'synctex.gz', 'run.xml';
push @generated_exts, 'fot', 'synctex.gz(busy)', 'bbl', 'blg', 'fdb_latexmk';

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}


$clean_ext .= '%R.ist %R.xdy';

#$pdflatex = 'xelatex -file-line-error -shell-escape -synctex=1';
#$pdflatex = 'lualatex --interaction=nonstopmode --shell-escape --synctex=1';
