#ifndef PRACTISE_H
#define PRACTISE_H

#include <algorithm>
#include <array>
#include <cstddef>
#include <iostream>
#include <map>
#include <string>
#include <string_view>
#include <vector>

// Print container.
template <typename ContainerT>
std::ostream &the_cout(ContainerT container) {
  int i = 0;
  for (const auto &v : container) {
    i++;
    std::cout << v << " ";
    if (i % 5 == 0) {
      std::cout << std::endl;
    }
  }
  std::cout << std::endl;
  return std::cout;
}
void testString();
void testFilesystem();
void testAlgorithm();
void testContainer();

using namespace std;
class Solution {
 public:
  int deleteAndEarn(vector<int> &nums) {
    map<int, int> numpoints;
    for (const auto i : nums) {
      numpoints[i] += i;
    }

    int x1 = -5, x2 = -3, x3 = -1;
    int f1 = 0, f2 = 0, f3 = 0, fn = 0;
    auto size = numpoints.size();
    auto head = numpoints.begin();
    if (size == 2) {
      head = numpoints.begin();
      x3 = head->first, f3 = head->second;
        }
    if (size == 3) {
      head = numpoints.begin();
      x2 = head->first, f2 = head->second;
      head++;
      x3 = head->first, f3 = head->second;
    }
    if (size > 3) {
      head = numpoints.begin();
      x1 = head->first, f1 = head->second;
      head++;
      x2 = head->first, f2 = head->second;
      head++;
      x3 = head->first, f3 = head->second;
    }

    for (head++; head != numpoints.end(); head++) {
      auto [xn, f4] = *head;
      auto flag = 0, f = 0;
      if (xn - x3 == 1) flag += 1;
      if (x3 - x2 == 1) flag += 2;
      if (x2 - x1 == 1) flag += 4;

      switch (flag) {
        case 0:
          fn = f1 + f2 + f3 + f4;
          break;
        case 1:
          fn = f1 + f2 + (f3 > f4 ? f3 : f4);
          break;
        case 2:
          fn = f1 + f4 + (f2 > f3 ? f2 : f4);
          break;
        case 3:
          f = f2 + f4;
          fn = f1 + (f > f3 ? f : f3);
          break;
        case 4:
          fn = f3 + f4 + (f1 > f2 ? f1 : f2);
          break;
        case 5:
          fn = (f1 > f2 ? f1 : f2) + (f3 > f4 ? f3 : f4);
          break;
        case 6:
          f = f1 + f3;
          fn = (f > f2 ? f : f2) + f4;
          break;
        case 7:
          fn = f1 + f3 > f2 + f4 ? f1 + f3 : f2 + f4;
          break;
      }

      x1 = x2, x2 = x3, x3 = xn;
      f1 = f2, f2 = f3, f3 = fn;
    }

    return fn;
  }
};
#endif /* PRACTISE_H */
