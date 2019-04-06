#include <string>
#include <algorithm>
#include <cstdint>
#include <stdexcept>


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

int64_t repair(char* x, size_t length, char* repair_alphabet, size_t base, char sign) {
    int64_t res = 0;
    int symbol;
    for (size_t i = length - 1; i > 0 && symbol >= 0; --i) {
        symbol = repair_alphabet[x[i]];
        res = res * base + symbol;
    }
    if (symbol < 0) {
        throw std::invalid_argument("value contains invalid symbols, can't cast to base");
    }
    if (sign) {
        return -res;
    }
    return res * base + repair_alphabet[x[0]];
}
