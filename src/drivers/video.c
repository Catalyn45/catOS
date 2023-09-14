#include "ports.h"
#include "../kernel/memory.h"

#define VIDEO_ADDRESS 0xb8000

#define MAX_ROWS 25
#define MAX_COLS 80

#define WHITE_ON_BLACK 0x0f

#define REG_SCREEN_CTL 0x3d4
#define REG_SCREEN_DATA 0x3d5

static void set_cursor(int offset) {
    offset /= 2;

    port_byte_out(REG_SCREEN_CTL, 14);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));

    port_byte_out(REG_SCREEN_CTL, 15);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset & 0xff));
}

static int get_cursor() {
    port_byte_out(REG_SCREEN_CTL, 14);
    int offset = port_byte_in(REG_SCREEN_DATA);

    // set the high
    offset <<= 8;

    port_byte_out(REG_SCREEN_CTL, 15);

    // set low
    offset |= port_byte_in(REG_SCREEN_DATA);

    return offset * 2;
}

static int get_offset(int row, int col) {
    int offset_big = row * MAX_COLS + col;
    return offset_big * 2;
}

static void print_chr(char c) {
    char* video_memory = (char*) VIDEO_ADDRESS;

    int offset = get_cursor();

    if (offset >= MAX_ROWS * MAX_COLS * 2) {
        // we need to scroll
        for (int i = 1; i < MAX_ROWS; ++i) {
            memcpy((unsigned char*)(get_offset(i - 1, 0) + VIDEO_ADDRESS), (unsigned char*)(get_offset(i, 0) + VIDEO_ADDRESS), MAX_COLS * 2);
        }

        unsigned char* last_line = (unsigned char*)(get_offset(MAX_ROWS - 1, 0) + VIDEO_ADDRESS);
        for (int i = 0; i < MAX_COLS * 2; ++i) {
            last_line[i] = '\0';
        }

        offset -= 2 * MAX_COLS;
    }

    if (c == '\n') {
        int current_row = offset / (2 * MAX_COLS);
        int next_line_offset = get_offset(current_row + 1, 0);
        set_cursor(next_line_offset);
        return;
    }

    video_memory[offset] = c;
    video_memory[offset + 1] = WHITE_ON_BLACK;

    offset += 2;
    set_cursor(offset);
}

void print(const char* s) {
    for (const char* chr = s; *chr != '\0'; ++chr) {
        print_chr(*chr);
    }
}
