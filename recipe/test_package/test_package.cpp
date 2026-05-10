#include <algorithm>
#include <iterator>

#include <foonathan/memory/container.hpp>
#include <foonathan/memory/memory_pool.hpp>
#include <foonathan/memory/namespace_alias.hpp>

int main()
{
    using namespace memory::literals;

    memory::memory_pool<> pool(memory::list_node_size<int>::value, 4_KiB);
    memory::list<int, memory::memory_pool<>> values(pool);

    values.push_back(3);
    values.push_back(1);
    values.push_back(2);
    values.sort();

    const int expected[] = {1, 2, 3};
    return std::equal(values.begin(), values.end(), std::begin(expected), std::end(expected)) ? 0 : 1;
}
