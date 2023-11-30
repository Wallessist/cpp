
#include "scratch/practise.h"

#include <unistd.h>

#include <algorithm>
#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <filesystem>
#include <iostream>
#include <iterator>
#include <limits>
#include <list>
#include <map>
#include <memory>
#include <ostream>
#include <random>
#include <sstream>
#include <string>
#include <string_view>
#include <vector>

class thestr {
  public:
  thestr():size(0) {std::cout << "Spawn!" << std::endl;}
  ~thestr() {std::cout << "Destroyed!" << std::endl;}
  int size;
};
thestr fthestr(){
  return thestr();
}
void f(thestr ts) {
  ts.size = 0;
  std::cout << "call f!" << std::endl;
}

void testString() {
  std::string str {"Hello world"};
  thestr();
  std::cout << "execution!" << std::endl;
}

void testFilesystem() {
  using namespace std::literals;
  auto sentence = "haha"sv;
  std::cout << sentence << std::endl;
}

void testAlgorithm() {
  std::default_random_engine rng(std::random_device{}());

  std::list<int> vec{1, 2, 3, 4, 5};
  the_cout(vec);
}

void testContainer() {
  std::numeric_limits<int> a;
  std::cout << a.max() << std::endl;
}

