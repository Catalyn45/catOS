#include "../drivers/video.h"

int main() {
    char s[] = "how are you?\n";
    for (char i = 'a'; i <= 'z'; ++i) {
        s[0] = i;
        print(s);
    }
}

