FLAGS = -W -Wall -ansi -pedantic

all: test

test: graph.o maxflow.o test.o
	g++ -o test graph.o maxflow.o test.o
	
test.o: test.cpp graph.h block.h
	g++ -o test.o -c test.cpp $(FLAGS)
	
graph.o: graph.cpp graph.h block.h
	g++ -o graph.o -c graph.cpp $(FLAGS)

maxflow.o: maxflow.cpp graph.h block.h
	g++ -o maxflow.o -c maxflow.cpp $(FLAGS)

clean:
	rm test *.o