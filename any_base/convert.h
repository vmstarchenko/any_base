#include <string>
#include <algorithm>
#include <cstdint>

inline std::string convert(uint64_t x, char* alphabet, size_t base, char sign) {
    if (!x) {
        return std::string(1, alphabet[0]);
    }

    std::string digits;
    size_t mod = 0;

    while (x) {
        mod = x % base;
        x = x / base;
        digits += alphabet[mod];
    }

    digits += sign;

    std::reverse(digits.begin(), digits.end());
    return digits;
}

inline std::string convert(uint64_t x, char* alphabet, size_t base) {
    if (!x) {
        return std::string(1, alphabet[0]);
    }

    std::string digits;
    size_t mod = 0;

    while (x) {
        mod = x % base;
        x = x / base;
        digits += alphabet[mod];
    }

    std::reverse(digits.begin(), digits.end());
    return digits;
}
