#include "memory.h"

void memcpy(unsigned char* dst, const unsigned char* src, unsigned int length) {
    for (unsigned int i = 0; i < length; ++i) {
        dst[i] = src[i];
    }
}
