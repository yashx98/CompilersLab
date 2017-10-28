%{
    #include <stdio.h>
    int yyerror(char *);
    extern int yylex(void);
%}

%token IDENTIFIER INT_CONS ZERO_CONS FLOAT_CONS CHAR_CONS STRING_LIT
%token LPAREN RPAREN LCURLY RCURLY LSQUARE RSQUARE
%token DOT ARROW INCR DECR TRANS COMMA
%token AMPER ASTER PLUS MINUS FSLASH PERCENT
%token LSHIFT RSHIFT
%token LT GT LTE GTE ISEQUAL ISNEQUAL
%token CARET BAR DBAR DAMPER
%token QUES COLON SCOLON
%token EQUALS ASTEREQ FSLASHEQ PERCENTEQ PLUSEQ MINUSEQ LSHIFTEQ RSHIFTEQ AMPEREQ CARETEQ BAREQ
%token TILDE EXCL HASH
%token VOID CHAR SHORT INT LONG FLOAT DOUBLE MATRIX SIGNED UNSIGNED BOOL
%token SWITCH CASE DEFAULT IF ELSE
%token WHILE DO FOR
%token GOTO CONTINUE BREAK RETURN

%start translation_unit

%%

primary_expression :
  IDENTIFIER {
  printf("primary_expression --> identifier\n");
  }
| INT_CONS {
  printf("primary_expression --> integer constant\n");
  }
| ZERO_CONS {
  printf("primary_expression --> zero constant\n");
}
| FLOAT_CONS {
  printf("primary_expression --> floating constant\n");
}
| CHAR_CONS {
  printf("primary_expression --> character constant\n");
}
| STRING_LIT {
  printf("primary_expression --> string-literal\n");
  }
| LPAREN expression RPAREN {
  printf("primary_expression --> ( expression )\n");
}
;

postfix_expression :
  primary_expression {
  printf("postfix_expression --> primary_expression\n");
}
| postfix_expression LSQUARE expression RSQUARE {
  printf("postfix_expression --> [ expression ]\n");
}
| postfix_expression LPAREN argument_expression_list_opt RPAREN {
  printf("postfix_expression --> ( argument_expression_list_opt )\n");
}
| postfix_expression DOT IDENTIFIER {
  printf("postfix_expression . identifier\n");
}
| postfix_expression ARROW IDENTIFIER {
  printf("postfix_expression --> postfix_expression -> identifier\n");
}
| postfix_expression INCR {
  printf("postfix_expression --> postfix_expression ++\n");
}
| postfix_expression DECR {
  printf("postfix_expression --> postfix_expression --\n");
}
| postfix_expression TRANS {
  printf("postfix_expression --> postfix_expression .'\n");
}
;

argument_expression_list_opt :
  %empty {
  printf("argument_expression_list_opt --> ε\n");
}
| argument_expression_list {
  printf("argument_expression_list_opt --> argument_expression_list\n");
}

argument_expression_list :
  assignment_expression {
  printf("argument_expression_list --> argument_expression\n");
}
| argument_expression_list COMMA assignment_expression {
  printf("assignment_expression_list --> assignment_expression_list , assignment_expression\n");
}
;

unary_expression :
  postfix_expression {
  printf("unary_expression --> postfix_expression\n");
}
| INCR unary_expression {
  printf("unary_expression --> ++ unary_expression\n");
}
| DECR unary_expression {
  printf("unary_expression --> -- unary_expression\n");
}
| unary_operator cast_expression {
  printf("unary_expression --> unary_operator cast_expression\n");
}
;

unary_operator :
  AMPER {
  printf("unary_operator --> &\n");
}
| ASTER {
  printf("unary_operator --> *\n");
}
| PLUS {
  printf("unary_operator --> +\n");
}
| MINUS {
  printf("unary_operator --> -\n");
}
;

cast_expression :
  unary_expression {
  printf("cast_expression --> unary_expression\n");
}
;

multiplicative_expression :
  cast_expression {
  printf("multiplicative_expression --> cast_expression\n");
}
| multiplicative_expression ASTER cast_expression {
  printf("multiplicative_expression --> multiplicative_expression * cast-expression\n");
}
| multiplicative_expression FSLASH cast_expression {
  printf("multiplicative_expression --> multiplicative_expression / cast_expression\n");
}
| multiplicative_expression PERCENT cast_expression {
  printf("multiplicative_expression --> multiplicative_expression %% cast_expression\n");
}
;

additive_expression :
  multiplicative_expression {
  printf("additive_expression --> multiplicative_expression\n");
}
| additive_expression PLUS multiplicative_expression {
  printf("additive_expression --> additive_expression + multiplicative_expression\n");
}
| additive_expression MINUS multiplicative_expression {
  printf("additive_expression --> additive_expression - multiplicative_expression\n");
}
;

shift_expression :
  additive_expression {
  printf("shift_expression --> additive_expression\n");
}
| shift_expression LSHIFT additive_expression {
  printf("shift_expression --> shift_expression << additive_expression");
}
| shift_expression RSHIFT additive_expression {
  printf("shift_expression --> shift_expression >> additive_expression\n");
}
;

relational_expression :
  shift_expression {
  printf("relational_expression --> shift_expression\n");
}
| relational_expression LT shift_expression {
  printf("relational_expression --> relational_expression < shift_expression\n");
}
| relational_expression GT shift_expression {
  printf("relational_expression --> relational_expression > shift_expression\n");
}
| relational_expression LTE shift_expression {
  printf("relational_expression --> relational_expression <= shift_expression\n");
}
| relational_expression GTE shift_expression {
  printf("relational_expression --> relational_expression >= shift_expression\n");
}
;

equality_expression :
  relational_expression {
  printf("equality_expression --> relational_expression\n");
}
| equality_expression ISEQUAL relational_expression {
  printf("equality_expression == relational_expression\n");
}
| equality_expression ISNEQUAL relational_expression {
  printf("equality_expression != relational_expression\n");
}
;

AND_expression :
  equality_expression {
  printf("AND_expression --> equality_expression\n");
}
| AND_expression AMPER equality_expression {
  printf("AND_expression --> AND_expression & equality_expression\n");
}
;

exclusive_OR_expression :
  AND_expression {
  printf("exclusive_OR_expression --> AND_expression\n");
}
| exclusive_OR_expression CARET AND_expression {
  printf("exclusive_OR_expression ^ AND_expression\n");
}
;

inclusive_OR_expression :
  exclusive_OR_expression {
  printf("inclusive_OR_expression --> exclusive_OR_expression\n");
}
| inclusive_OR_expression BAR exclusive_OR_expression {
  printf("inclusive_OR_expression --> inclusive_OR_expression | exclusive_OR_expression\n");
}
;

logical_AND_expression :
  inclusive_OR_expression {
  printf("logical_AND_expression --> inclusive_OR_expression\n");
}
| logical_AND_expression DAMPER inclusive_OR_expression {
  printf("logical_AND_expression --> logical_AND_expression && inclusive_OR_expression\n");
}
;

logical_OR_expression :
  logical_AND_expression {
  printf("logical_OR_expression --> logical_AND_expression\n");
}
| logical_OR_expression DBAR logical_AND_expression {
  printf("logical_OR_expression --> logical_OR_expression || logical_AND_expression\n");
}
;

conditional_expression :
  logical_OR_expression {
  printf("conditional_expression --> logical_OR_expression\n");
}
| logical_OR_expression QUES expression COLON conditional_expression {
  printf("conditional_expression --> logical_OR_expression ? expression : conditional_expression\n");
}
;

assignment_expression_opt :
  %empty {
  printf("assignment_expression_opt --> ε\n");
}
| assignment_expression {
  printf("assignment_expression_opt --> assignment_expression\n");
}
;

assignment_expression :
  conditional_expression {
  printf("assignment_expression --> conditional_expression\n");
}
| unary_expression assignment_operator assignment_expression {
  printf("assignment_expression --> unary_expression assignment_operator assignment_expression\n");
}
;

assignment_operator :
  EQUALS {
  printf("assignment_operator --> =\n");
}
| ASTEREQ {
  printf("assignment_operator --> *=\n");
}
| FSLASHEQ {
  printf("assignment_operator --> /=\n");
}
| PERCENTEQ {
  printf("assignment_operator --> %%=\n");
}
| PLUSEQ {
  printf("assignment_operator --> +=\n");
}
| MINUSEQ {
  printf("assignment_operator --> -=\n");
}
| LSHIFTEQ {
  printf("assignment_operator --> <<=\n");
}
| RSHIFTEQ {
  printf("assignment_operator --> >>=\n");
}
| AMPEREQ {
  printf("assignment_operator --> &=\n");
}
| CARETEQ {
  printf("assignment_operator --> ^=\n");
}
| BAREQ {
  printf("assignment_operator --> |=\n");
}
;

expression :
  assignment_expression {
  printf("expression --> assignment_expression\n");
}
| expression COMMA assignment_expression {
  printf("expression --> expression , assignment_expression\n");
}
;

constant_expression :
  conditional_expression {
  printf("constant_expression --> conditional_expression\n");
}
;

declaration :
  declaration_specifiers init_declarator_list_opt SCOLON{
  printf("declaration --> declaration_specifiers init_declarator_list_opt ;\n");
}
;

declaration_specifiers_opt :
  %empty {
  printf("declaration_specifiers_opt --> ε");
}
| declaration_specifiers {
  printf("declaration_specifiers_opt --> declaration_specifiers");
}
;

declaration_specifiers :
  type_specifier declaration_specifiers_opt {
  printf("declaration_specifiers --> type_specifier declaration_specifiers_opt\n");
}
;

init_declarator_list_opt :
  %empty {
  printf("init_declarator_list_opt --> ε\n");
}
| init_declarator_list {
  printf("init_declarator_list_opt --> init_declarator_list\n");
}
;

init_declarator_list :
  init_declarator {
  printf("init_declarator_list --> init_declarator\n");
}
| init_declarator_list COMMA init_declarator {
  printf("init_declarator_list --> init_declarator_list , init_declarator\n");
}
;

init_declarator :
  declarator {
  printf("init_declarator --> declarator\n");
}
| declarator EQUALS initializer {
  printf("declarator = initializer\n");
}
;

type_specifier :
  VOID {
  printf("type_specifier --> void\n");
}
| CHAR {
  printf("type_specifier --> char\n");
}
| SHORT {
  printf("type_specifier --> short\n");
}
| INT {
  printf("type_specifier --> int\n");
}
| LONG {
  printf("type_specifier --> long\n");
}
| FLOAT {
  printf("type_specifier --> float\n");
}
| DOUBLE {
  printf("type_specifier --> double\n");
}
| MATRIX {
  printf("type_specifier --> Matrix\n");
}
| SIGNED {
  printf("type_specifier --> signed\n");
}
| UNSIGNED {
  printf("type_specifier --> unsigned\n");
}
| BOOL {
  printf("type_specifier --> Bool\n");
}
;

declarator :
  pointer_opt direct_declarator {
  printf("declarator --> pointer_opt direct_declarator\n");
}

direct_declarator :
  IDENTIFIER {
  printf("direct_declarator --> identifier\n");
}
| LPAREN declarator RPAREN {
  printf("direct_declarator --> ( declarator )\n");
}
| direct_declarator LSQUARE assignment_expression_opt RSQUARE {
  printf("direct_declarator --> direct_declarator [ assignment_expression_opt ]\n");
}
| direct_declarator LPAREN parameter_type_list RPAREN {
  printf("direct_declarator --> direct_declarator ( parameter_type_list )\n");
}
| direct_declarator LPAREN identifier_list_opt RPAREN {
  printf("direct_declarator --> direct_declarator ( identifier_list_opt )\n");
}
;

pointer_opt :
  %empty {
  printf("pointer_opt --> ε\n");
}
| pointer {
  printf("pointer_opt --> pointer\n");
}
;

pointer :
  ASTER pointer_opt {
  printf("* pointer_opt\n");
}
;

parameter_type_list :
  parameter_list {
  printf("parameter_type_list --> parameter_list\n");
}
;

parameter_list :
  parameter_declaration {
  printf("parameter_list --> parameter_declaration\n");
}
| parameter_list COMMA parameter_declaration {
  printf("parameter_list --> parameter_list , parameter_declaration\n");
}
;

parameter_declaration :
  declaration_specifiers declarator {
  printf("parameter_declaration --> declaration_specifiers declarator\n");
}
| declaration_specifiers {
  printf("parameter_declaration --> declaration_specifiers\n");
}
;

identifier_list_opt :
  %empty {
  printf("identifier_list_opt --> ε\n");
}
| identifier_list {
  printf("identifier_list_opt --> identifier_list\n");
}
;

identifier_list :
  IDENTIFIER {
  printf("identifier_list --> identifier\n");
}
| identifier_list COMMA IDENTIFIER{
  printf("identifier_list --> identifier_list , identifier\n");
}
;

initializer :
  assignment_expression {
  printf("initializer --> assignment_expression\n");
}
| LCURLY initializer_row_list RCURLY {
  printf("initializer --> { initializer_row_list }\n");
}
;

initializer_row_list :
  initializer_row {
  printf("initializer_row_list --> initializer_row\n");
}
| initializer_row_list SCOLON initializer_row {
  printf("initializer_row_list --> initializer_row_list ; initializer_row\n");
}
;

initializer_row :
  designation_opt initializer {
  printf("initializer_row --> designation_opt initializer\n");
}
| initializer_row COMMA designation_opt initializer {
  printf("initializer_row , designation_opt initializer\n");
}
;

designation_opt :
  %empty {
  printf("designation_opt --> ε\n");
}
| designation {
  printf("designation_opt --> designation\n");
}
;

designation :
  designator_list EQUALS {
  printf("designation --> designator_list =\n");
}
;

designator_list :
  designator {
  printf("designator_list --> designator\n");
}
| designator_list designator {
  printf("designator_list --> designator_list designator\n");
}
;

designator :
  LSQUARE constant_expression RSQUARE {
  printf("[ constant_expression ]\n");
}
| DOT IDENTIFIER {
  printf("designator --> . identifier\n");
}
;

statement :
  labeled_statement {
  printf("statement --> labeled_statement\n");
}
| compound_statement {
  printf("statement --> compound_statement\n");
}
| expression_statement {
  printf("statement --> expression_statement\n");
}
| selection_statement {
  printf("statement --> selection_statement\n");
}
| iteration_statement {
  printf("statement --> iteration_statement\n");
}
| jump_statement {
  printf("statement --> jump_statement\n");
}
;

labeled_statement :
  IDENTIFIER COLON statement {
  printf("labeled_statement --> identifier : statement\n");
}
| CASE constant_expression COLON statement {
  printf("labeled_statement --> case constant_expression : statement\n");
}
| DEFAULT COLON statement {
  printf("labeled_statement --> default : statement\n");
}
;

compound_statement :
  LCURLY block_item_list_opt RCURLY {
  printf("compound_statement --> { block_item_list_opt }\n");
}
;

block_item_list_opt :
  %empty {
  printf("block_item_list_opt --> ε\n");
}
| block_item_list {
  printf("block_item_list_opt --> block_item_list\n");
}
;

block_item_list :
  block_item {
  printf("block_item_list --> block_item\n");
}
| block_item_list block_item {
  printf("block_item_list --> block_item_list block_item\n");
}
;

block_item :
  declaration {
  printf("block_item --> declaration\n");
}
| statement {
  printf("block_item --> statement\n");
}
;

expression_statement :
  expression_opt SCOLON{
  printf("expression_statement --> expression_opt ;\n");
}
;

expression_opt :
  %empty {
  printf("expression_opt --> ε\n");
}
| expression {
  printf("expression_opt --> expression\n");
}
;

selection_statement :
  IF LPAREN expression RPAREN statement {
  printf("selection_statement --> if ( expression ) statement\n");
}
| IF LPAREN expression RPAREN statement ELSE statement {
  printf("selection_statement --> if ( expression ) statement else statement\n");
}
| SWITCH LPAREN expression RPAREN statement{
  printf("selection_statement --> switch ( expression ) statement\n");
}
;

iteration_statement :
  WHILE LPAREN expression RPAREN statement {
  printf("iteration_statement --> while ( expression ) statement\n");
}
| DO statement WHILE LPAREN expression RPAREN SCOLON {
  printf("iteration_statement --> do statement while ( expression ) ;\n");
}
| FOR LPAREN expression_opt SCOLON expression_opt SCOLON expression_opt RPAREN statement {
  printf("iteration_statement --> for ( expression_opt ; expression_opt ; expression_opt ) statement\n");
}
| FOR LPAREN declaration expression_opt SCOLON expression_opt RPAREN statement {
  printf("iteration_statement --> for ( declaration expression_opt ; expression_opt ) statement\n");
}
;

jump_statement :
  GOTO IDENTIFIER SCOLON {
  printf("jump_statement --> goto identifier ;\n");
}
| CONTINUE SCOLON {
  printf("jump_statement --> continue ;\n");
}
| BREAK SCOLON {
  printf("jump_statement --> break ;\n");
}
| RETURN expression_opt SCOLON {
  printf("return expression_opt\n");
}
;

translation_unit :
  external_declaration {
  printf("translation_unit --> external_declaration\n");
}
| translation_unit external_declaration {
  printf("translation_unit --> translation_unit external_declaration\n");
}
;

external_declaration :
  function_definition {
  printf("external_declaration --> function_definition\n");
}
| declaration {
  printf("external_declaration --> declaration\n");
}
;

function_definition :
  declaration_specifiers declarator declaration_list_opt compound_statement {
  printf("function_definition --> declaration_specifiers declarator declaration_list_opt compound_statement\n");
}
;

declaration_list_opt :
  %empty {
  printf("declaration_list_opt --> ε\n");
}
| declaration_list {
  printf("declaration_list_opt --> declaration_list\n");
}
;

declaration_list :
  declaration {
  printf("declaration_list --> declaration\n");
}
| declaration_list declaration {
  printf("declaration_list --> declaration_list declaration\n");
}
;

%%

int yyerror(char *s){
    printf("Parser Error : %s\n",s);
    exit(0);
}

