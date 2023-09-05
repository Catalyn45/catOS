int main() {
    char* video_memory = (char*) 0xb8000;

    video_memory[0] = 'X';
    video_memory[2] = 'A';

    return 0;
}
