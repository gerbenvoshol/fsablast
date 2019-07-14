// readFasta.c
// Copyright (c) 2005, Michael Cameron
// Permission to use this code is freely granted under the BSD license agreement,
// provided that this statement is retained.
//
// Code for reading a FASTA format file and extracting sequence and description
// information

#include "blast.h"
#include <stdio.h>
#include <errno.h>

#include "seqio.h"

int4 readFasta_bufferAlloc;
int4 readFasta_sequenceBufferAlloc;
char* readFasta_lineBuffer;
char readFasta_endReached;

char* readFasta_filename;
FILE* readFasta_file;
int4 readFasta_lineLength;

SEQFILE *sqfp = NULL; // The file containing the sequence data

// Open FASTA file for reading
void readFasta_open(char* filename)
{
	sqfp = seqfopen(filename, "r", NULL);
	if (!sqfp) {
		fprintf(stderr, "Unable to open: %s\n", filename);
		exit(1);
	}
}

// Read a description and sequence from file, return 0 if end of file, otherwise 1
int4 readFasta_readSequence()
{
	if (((readFasta_sequenceBuffer = seqfgetseq(sqfp, &readFasta_sequenceLength, 0)) == NULL) || (readFasta_sequenceLength == 0)) {
		return 0;
	}

	readFasta_descriptionBuffer = seqfdescription(sqfp, 0);
	readFasta_descriptionLength = strlen(readFasta_descriptionBuffer);

	return 1;
}

// Close the FASTA file and free memory
void readFasta_close()
{
	seqfclose(sqfp);
}
