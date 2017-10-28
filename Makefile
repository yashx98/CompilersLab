a.out: mainfn.o libresult.a
	gcc mainfn.o -L. -lresult
mainfn.o: mainfn.c  myl.h
	gcc -Wall -c mainfn.c
libresult.a: ass2_15CS10056.o
	ar -rcs libresult.a ass2_15CS10056.o 
ass2_15CS10056.o: ass2_15CS10056.c myl.h
	gcc -Wall -c ass2_15CS10056.c
clean:
	rm a.out mainfn.o libresult.a ass2_15CS10056.o
