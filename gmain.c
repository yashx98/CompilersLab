#include "lex.yy.c"
int main(int argc ,char *argv[]){
  int parser=yyparse();
  if(parser==-1)
  {
  	printf("Parsing failed.\n");
  }
  return parser;
}
