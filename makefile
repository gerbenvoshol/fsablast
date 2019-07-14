
INC=include
SRC=src
OBJ=obj
INSTALL_DIR=/usr/local/bin

PLATFORM= $(shell echo `uname`)

# Defaults
CC=gcc
CFLAGS=-I$(INC) -O3
LDFLAGS=-lm

# Linux
ifeq ($(PLATFORM), Linux)
    CC=gcc
    # Use for production build:
    CFLAGS=-I$(INC) -O3 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE
    # Use for debugging:
    #CFLAGS=-I$(INC) -O3 -fsanitize=address -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE
    LDFLAGS=-lm -lz
endif

# Mac
ifeq ($(PLATFORM), Darwin)
    CC=/usr/local/bin/gcc-8
    #CC=gcc
    CFLAGS=-I$(INC) -O3 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE
    #CFLAGS=-I$(INC) -pipe -O2 -no-cpp-precomp -Wno-long-double
    LDFLAGS=-lm -lz
endif

# Sun
ifeq ($(PLATFORM), SunOS)
    CC=gcc
    CFLAGS=-I$(INC) -O3 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE
    LDFLAGS=-lm -lz
endif

#Debug
#CFLAGS=-I$(INC) -g

OBJFILES= $(OBJ)/alignments.o $(OBJ)/bytepackGappedScoring.o $(OBJ)/descriptions.o $(OBJ)/encoding.o $(OBJ)/fasterGappedExtension.o $(OBJ)/gappedExtension.o $(OBJ)/gappedScoring.o $(OBJ)/nuGappedScoring.o $(OBJ)/global.o $(OBJ)/hitMatrix.o $(OBJ)/karlin.o $(OBJ)/memBlocks.o $(OBJ)/memSingleBlock.o $(OBJ)/nucleotideLookup.o $(OBJ)/oldGappedScoring.o $(OBJ)/oldSemiGappedScoring.o $(OBJ)/parameters.o $(OBJ)/print.o $(OBJ)/PSSMatrix.o $(OBJ)/qPosList.o $(OBJ)/readFasta.o $(OBJ)/readFile.o $(OBJ)/scoreMatrix.o $(OBJ)/semiGappedScoring.o $(OBJ)/statistics.o $(OBJ)/ungappedExtension.o $(OBJ)/wordLookupDFA.o $(OBJ)/writeFile.o $(OBJ)/constants.o $(OBJ)/smithWatermanTraceback.o $(OBJ)/smithWatermanScoring.o $(OBJ)/tableGappedScoring.o $(OBJ)/vbyte.o $(OBJ)/unpack.o $(OBJ)/index.o $(OBJ)/postings.o $(OBJ)/hashcounter.o $(OBJ)/writedb.o $(OBJ)/readdb.o $(OBJ)/search.o $(OBJ)/wildcards.o $(OBJ)/dust.o $(OBJ)/seg.o
HEADERFILES= $(INC)/alignments.h $(INC)/blast.h $(INC)/bytepackGappedScoring.h $(INC)/descriptions.h $(INC)/encoding.h $(INC)/fasterGappedExtension.h $(INC)/gappedExtension.h $(INC)/nuGappedScoring.h $(INC)/gappedScoring.h $(INC)/global.h $(INC)/hitMatrix.h $(INC)/karlin.h $(INC)/memBlocks.h $(INC)/memSingleBlock.h $(INC)/nucleotideLookup.h $(INC)/oldGappedScoring.h $(INC)/oldSemiGappedScoring.h $(INC)/parameters.h $(INC)/print.h $(INC)/PSSMatrix.h $(INC)/qPosList.h $(INC)/readFasta.h $(INC)/readFile.h $(INC)/scoreMatrix.h $(INC)/semiGappedScoring.h $(INC)/statistics.h $(INC)/ungappedExtension.h $(INC)/wordLookupDFA.h $(INC)/writeFile.h $(INC)/constants.h $(INC)/smithWatermanTraceback.h $(INC)/smithWatermanScoring.h $(INC)/tableGappedScoring.h $(INC)/vbyte.h $(INC)/unpack.h $(INC)/index.h $(INC)/postings.h $(INC)/hashcounter.h $(INC)/writedb.h $(INC)/readdb.h $(INC)/search.h $(INC)/wildcards.h $(INC)/dust.h $(INC)/seg.h
SRCFILES= $(SRC)/alignments.c $(SRC)/blast.c $(SRC)/bytepackGappedScoring.c $(SRC)/descriptions.c $(SRC)/encoding.c $(SRC)/fasterGappedExtension.c $(SRC)/gappedExtension.c $(SRC)/gappedScoring.c $(SRC)/nuGappedScoring.c $(SRC)/global.c $(SRC)/hitMatrix.c $(SRC)/karlin.c $(SRC)/memBlocks.c $(SRC)/memSingleBlock.c $(SRC)/nucleotideLookup.c $(SRC)/oldGappedScoring.c $(SRC)/oldSemiGappedScoring.c $(SRC)/parameters.c $(SRC)/print.c $(SRC)/PSSMatrix.c $(SRC)/qPosList.c $(SRC)/readFasta.c $(SRC)/readFile.c $(SRC)/scoreMatrix.c $(SRC)/semiGappedScoring.c $(SRC)/statistics.c $(SRC)/ungappedExtension.c $(SRC)/wordLookupDFA.c $(SRC)/writeFile.c $(SRC)/constants.c $(SRC)/smithWatermanTraceback.c $(SRC)/smithWatermanScoring.c $(SRC)/tableGappedScoring.c $(SRC)/vbyte.c $(SRC)/unpack.c $(SRC)/index.c $(SRC)/postings.c $(SRC)/hashcounter.c $(SRC)/writedb.c $(SRC)/readdb.c $(SRC)/search.c $(SRC)/wildcards.c $(SRC)/dust.c $(SRC)/seg.c
all: fsablast fsaformatdb fsareaddb fsassearch fsacluster

universe: fsablast fsablast-debug fsablast1 fsablast12 fsablast123 fsassearch fsaformatdb fsadust fsaprintDescription fsareaddb fsaverboseBlast fsacluster fsarsdb fsachooseWilds fsacreateindex fsareadNcbidb

fsablast: $(OBJ)/blast.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fsablast $(OBJ)/blast.o $(OBJFILES) $(LDFLAGS) 
fsassearch: $(OBJ)/ssearch.o $(OBJFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o fsassearch $(OBJ)/ssearch.o $(OBJFILES) $(LDFLAGS)
fsablast-debug: $(SRC)/blast.c $(SRCFILES)
	$(CC) $(CFLAGS) -g -o fsablast-debug $(SRCFILES) $(LDFLAGS) 
fsablast1: $(SRC)/blast.c $(SRCFILES)
	$(CC) $(CFLAGS) -DNO_STAGE2 -o fsablast1 $(SRCFILES) $(LDFLAGS) 
fsablast12: $(SRC)/blast.c $(SRCFILES)
	$(CC) $(CFLAGS) -DNO_STAGE3 -o fsablast12 $(SRCFILES) $(LDFLAGS) 
fsablast123: $(SRC)/blast.c $(SRCFILES)
	$(CC) $(CFLAGS) -DNO_STAGE4 -o fasblast123 $(SRCFILES) $(LDFLAGS) 
fsablast-bitlookup: $(SRC)/blast.c $(SRCFILES)
	$(CC) $(CFLAGS) -DBITLOOKUP -o fsablast-bitlookup $(SRCFILES) $(LDFLAGS) 
fsaverboseBlast: $(SRC)/blast.c $(SRCFILES)
	$(CC) $(CFLAGS) -DVERBOSE -o fsaverboseBlast $(SRCFILES) $(LDFLAGS) 
fsaformatdb: $(OBJ)/formatdb.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fsaformatdb $(OBJ)/formatdb.o $(OBJFILES) $(LDFLAGS) 
fsacreateindex: $(OBJ)/createindex.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fsacreateindex $(OBJ)/createindex.o $(OBJFILES) $(LDFLAGS) 
fsareaddb: $(OBJ)/readdbApp.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fasreaddb $(OBJ)/readdbApp.o $(OBJFILES) $(LDFLAGS) 
fsachooseWilds: $(OBJ)/chooseWilds.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fsachooseWilds $(OBJ)/chooseWilds.o $(OBJFILES) $(LDFLAGS) 
fsadust: $(OBJ)/dustApp.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fsadust $(OBJ)/dustApp.o $(OBJFILES) $(LDFLAGS) 
fsaprintDescription: $(OBJ)/printDescription.o $(OBJFILES)
	$(CC) $(CFLAGS) $ -o fsaprintDescription $(OBJ)/printDescription.o $(OBJFILES) $(LDFLAGS) 
fsacluster: $(OBJ)/cluster.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fsacluster $(OBJ)/cluster.o $(OBJFILES) $(LDFLAGS) 
fsarsdb: $(OBJ)/rsdb.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fsarsdb $(OBJ)/rsdb.o $(OBJFILES) $(LDFLAGS) 
fsareadNcbidb: $(OBJ)/readNcbidb.o $(OBJFILES)
	$(CC) $(CFLAGS) -o fsareadNcbidb $(OBJ)/readNcbidb.o $(OBJFILES) $(LDFLAGS) 

$(OBJ)/chooseWilds.o: $(SRC)/chooseWilds.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/chooseWilds.o $(SRC)/chooseWilds.c
$(OBJ)/readdbApp.o: $(SRC)/readdbApp.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/readdbApp.o $(SRC)/readdbApp.c
$(OBJ)/dustApp.o: $(SRC)/dustApp.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/dustApp.o $(SRC)/dustApp.c
$(OBJ)/printDescription.o: $(SRC)/printDescription.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/printDescription.o $(SRC)/printDescription.c
$(OBJ)/formatdb.o: $(SRC)/formatdb.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/formatdb.o $(SRC)/formatdb.c
$(OBJ)/createindex.o: $(SRC)/createindex.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/createindex.o $(SRC)/createindex.c
$(OBJ)/blast.o: $(SRC)/blast.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/blast.o $(SRC)/blast.c
$(OBJ)/cluster.o: $(SRC)/cluster.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/cluster.o $(SRC)/cluster.c
$(OBJ)/rsdb.o: $(SRC)/rsdb.c $(SRC)/identityAlign.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/rsdb.o $(SRC)/rsdb.c
$(OBJ)/readNcbidb.o: $(SRC)/readNcbidb.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/readNcbidb.o $(SRC)/readNcbidb.c

$(OBJ)/alignments.o: $(SRC)/alignments.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/alignments.o $(SRC)/alignments.c
$(OBJ)/bytepackGappedScoring.o: $(SRC)/bytepackGappedScoring.c $(SRC)/fasterBytepackGappedScoring.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/bytepackGappedScoring.o $(SRC)/bytepackGappedScoring.c
$(OBJ)/constants.o: $(SRC)/constants.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/constants.o $(SRC)/constants.c
$(OBJ)/descriptions.o: $(SRC)/descriptions.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/descriptions.o $(SRC)/descriptions.c
$(OBJ)/encoding.o: $(SRC)/encoding.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/encoding.o $(SRC)/encoding.c
$(OBJ)/gappedExtension.o: $(SRC)/gappedExtension.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/gappedExtension.o $(SRC)/gappedExtension.c
$(OBJ)/fasterGappedExtension.o: $(SRC)/fasterGappedExtension.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/fasterGappedExtension.o $(SRC)/fasterGappedExtension.c
$(OBJ)/gappedScoring.o: $(SRC)/gappedScoring.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/gappedScoring.o $(SRC)/gappedScoring.c
$(OBJ)/nuGappedScoring.o: $(SRC)/nuGappedScoring.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/nuGappedScoring.o $(SRC)/nuGappedScoring.c
$(OBJ)/global.o: $(SRC)/global.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/global.o $(SRC)/global.c
$(OBJ)/hitMatrix.o: $(SRC)/hitMatrix.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/hitMatrix.o $(SRC)/hitMatrix.c
$(OBJ)/karlin.o: $(SRC)/karlin.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/karlin.o $(SRC)/karlin.c
$(OBJ)/memBlocks.o: $(SRC)/memBlocks.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/memBlocks.o $(SRC)/memBlocks.c
$(OBJ)/memSingleBlock.o: $(SRC)/memSingleBlock.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/memSingleBlock.o $(SRC)/memSingleBlock.c
$(OBJ)/nucleotideLookup.o: $(SRC)/nucleotideLookup.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/nucleotideLookup.o $(SRC)/nucleotideLookup.c
$(OBJ)/oldGappedScoring.o: $(SRC)/oldGappedScoring.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/oldGappedScoring.o $(SRC)/oldGappedScoring.c
$(OBJ)/oldSemiGappedScoring.o: $(SRC)/oldSemiGappedScoring.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/oldSemiGappedScoring.o $(SRC)/oldSemiGappedScoring.c
$(OBJ)/parameters.o: $(SRC)/parameters.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/parameters.o $(SRC)/parameters.c
$(OBJ)/print.o: $(SRC)/print.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/print.o $(SRC)/print.c
$(OBJ)/PSSMatrix.o: $(SRC)/PSSMatrix.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/PSSMatrix.o $(SRC)/PSSMatrix.c
$(OBJ)/qPosList.o: $(SRC)/qPosList.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/qPosList.o $(SRC)/qPosList.c
$(OBJ)/readFasta.o: $(SRC)/readFasta.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/readFasta.o $(SRC)/readFasta.c
$(OBJ)/readFile.o: $(SRC)/readFile.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/readFile.o $(SRC)/readFile.c
$(OBJ)/scoreMatrix.o: $(SRC)/scoreMatrix.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/scoreMatrix.o $(SRC)/scoreMatrix.c
$(OBJ)/semiGappedScoring.o: $(SRC)/semiGappedScoring.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/semiGappedScoring.o $(SRC)/semiGappedScoring.c
$(OBJ)/statistics.o: $(SRC)/statistics.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/statistics.o $(SRC)/statistics.c
$(OBJ)/ungappedExtension.o: $(SRC)/ungappedExtension.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/ungappedExtension.o $(SRC)/ungappedExtension.c
$(OBJ)/wordLookupDFA.o: $(SRC)/wordLookupDFA.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/wordLookupDFA.o $(SRC)/wordLookupDFA.c
$(OBJ)/writeFile.o: $(SRC)/writeFile.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/writeFile.o $(SRC)/writeFile.c
$(OBJ)/smithWatermanTraceback.o: $(SRC)/smithWatermanTraceback.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/smithWatermanTraceback.o $(SRC)/smithWatermanTraceback.c
$(OBJ)/smithWatermanScoring.o: $(SRC)/smithWatermanScoring.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/smithWatermanScoring.o $(SRC)/smithWatermanScoring.c
$(OBJ)/tableGappedScoring.o: $(SRC)/tableGappedScoring.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/tableGappedScoring.o $(SRC)/tableGappedScoring.c
$(OBJ)/vbyte.o: $(SRC)/vbyte.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/vbyte.o $(SRC)/vbyte.c
$(OBJ)/unpack.o: $(SRC)/unpack.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/unpack.o $(SRC)/unpack.c
$(OBJ)/index.o: $(SRC)/index.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/index.o $(SRC)/index.c
$(OBJ)/hashcounter.o: $(SRC)/hashcounter.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/hashcounter.o $(SRC)/hashcounter.c
$(OBJ)/postings.o: $(SRC)/postings.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/postings.o $(SRC)/postings.c
$(OBJ)/writedb.o: $(SRC)/writedb.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/writedb.o $(SRC)/writedb.c
$(OBJ)/readdb.o: $(SRC)/readdb.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/readdb.o $(SRC)/readdb.c
$(OBJ)/search.o: $(SRC)/search.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/search.o $(SRC)/search.c
$(OBJ)/wildcards.o: $(SRC)/wildcards.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/wildcards.o $(SRC)/wildcards.c
$(OBJ)/ssearch.o: $(SRC)/blast.c $(HEADERFILES)
	$(CC) $(CFLAGS) -DSSEARCH -c -o $(OBJ)/ssearch.o $(SRC)/blast.c
$(OBJ)/dust.o: $(SRC)/dust.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/dust.o $(SRC)/dust.c
$(OBJ)/seg.o: $(SRC)/seg.c $(HEADERFILES)
	$(CC) $(CFLAGS) -c -o $(OBJ)/seg.o $(SRC)/seg.c

install:
	cp fsa* /usr/local/bin/
	mkdir -p /usr/share/fsablast/data
	cp data/* /usr/share/fsablast/data
	chmod a+r /usr/share/fsablast/data/*
	echo "[NCBI]" > ~/.ncbirc
	echo "Data=/usr/share/fsablast/data" >> ~/.ncbirc
	#chmod a+rw ~/.ncbirc

clean:
	rm -f fsablast fsablast-debug fsablast1 fsablast12 fsablast123 fsassearch fsaformatdb fsadust fsaprintDescription fsareaddb fsaverboseBlast $(OBJ)/* fsacluster fsarsdb fsachooseWilds fsacreateindex fsareadNcbidb

