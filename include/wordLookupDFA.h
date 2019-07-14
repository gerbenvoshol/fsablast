#ifndef _wordLookupDFA_
#define _wordLookupDFA_

struct group
{
	unsigned char* nextWords;
    struct group* nextGroups;
};

extern uint2* wordLookupDFA_additionalQueryPositions;
extern int4 wordLookupDFA_numAdditionalQueryPositions;
extern struct group *wordLookupDFA_groups;
extern int4 wordLookupDFA_numCodes, wordLookupDFA_wordLength, wordLookupDFA_numBlocks;

// Build the word-lookup structure
void wordLookupDFA_build(struct PSSMatrix PSSMatrix, int4 numCodes, int4 wordLength);

// Print4 the contents of the word lookup table
void wordLookupDFA_print();

// Free memory used by the word lookup table
void wordLookupDFA_free();

#endif

