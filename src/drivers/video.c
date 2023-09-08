void print(char c) {
    char* video_memory = (char*) 0xb8000;
    video_memory[0] = c;
}
