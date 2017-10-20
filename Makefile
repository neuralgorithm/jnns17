CC = gcc
MPICC = mpicc
CFLAGS = -std=c99 -Wall -O3
OMPFLAGS = -fopenmp
MISC_OBJS = mt19937ar-cok.o timer.o

all: if ifomp ifomp2 ifmpi ifhyb

if: if.o $(MISC_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -lm
if.o: if.c
	$(CC) $(CFLAGS) -o $@ -c $<
ifomp: ifomp.o $(MISC_OBJS)
	$(CC) $(OMPFLAGS) $(CFLAGS) -o $@ $^ -lm
ifomp.o: ifomp.c
	$(CC) $(OMPFLAGS) $(CFLAGS) -o $@ -c $<
ifomp2: ifomp2.o $(MISC_OBJS)
	$(CC) $(OMPFLAGS) $(CFLAGS) -o $@ $^ -lm
ifomp2.o: ifomp2.c
	$(CC) $(OMPFLAGS) $(CFLAGS) -o $@ -c $<
ifmpi: ifmpi.o $(MISC_OBJS)
	$(MPICC) $(CFLAGS) -o $@ $^ -lm
ifmpi.o: ifmpi.c
	$(MPICC) $(CFLAGS) -o $@ -c $<
ifhyb: ifhyb.o $(MISC_OBJS)
	$(MPICC) $(OMPFLAGS) $(CFLAGS) -o $@ $^ -lm
ifhyb.o: ifhyb.c
	$(MPICC) $(OMPFLAGS) $(CFLAGS) -o $@ -c $<

mt19937ar-cok.o: mt19937ar-cok.c
	$(CC) $(CFLAGS) -o $@ -c $<
timer.o: timer.c
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	rm -f if ifomp ifomp2 ifmpi ifhyb *~ *.o

mpirun:
	mpirun -hostfile hostfile -np 10 ./ifhyb
