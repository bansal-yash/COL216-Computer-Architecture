#include <iostream>
#include <algorithm>
#include <cmath>
#include <vector>

// ./csim 256 4 16 write-allocate write-back lru < input.txt
// ./csim 256 4 16 write-allocate write-back fifo < input.txt
// ./csim 256 4 16 write-allocate write-through lru < input.txt
// ./csim 256 4 16 write-allocate write-through fifo < input.txt
// ./csim 256 4 16 no-write-allocate write-back lru < input.txt
// ./csim 256 4 16 no-write-allocate write-back fifo < input.txt
// ./csim 256 4 16 no-write-allocate write-through lru < input.txt
// ./csim 256 4 16 no-write-allocate write-through fifo < input.txt

using namespace std;

int no_of_sets;
int no_of_blocks;
int no_of_bytes;
bool write_allocate = true;
bool write_method = 0; // 1 for write though, 0 for write back
string lru_or_fifo = "";

int total_loads = 0;
int total_stores = 0;
int load_hit = 0;
int load_miss = 0;
int store_hit = 0;
int store_miss = 0;
int total_hits = 0;
int total_miss = 0;
long long total_cycles = 0;

string hexToBinary(string hex)
{
    string binary = "";
    for (int i = 0; i < int(hex.length()); i++)
    {
        char hex_char = hex[i];
        int num;
        if (hex_char >= '0' && hex_char <= '9')
        {
            num = hex_char - '0';
        }
        else if (hex_char >= 'A' && hex_char <= 'F')
        {
            num = hex_char - 'A' + 10;
        }
        else if (hex_char >= 'a' && hex_char <= 'f')
        {
            num = hex_char - 'a' + 10;
        }
        else
        {
            continue;
        }
        for (int i = 3; i >= 0; --i)
        {
            binary.push_back((num & (1 << i)) ? '1' : '0');
        }
    }
    return binary;
}

class cache_block
{
public:
    int *cache_block_array;

    cache_block()
    {
        cache_block_array = new int[no_of_bytes / 4];
        for (int i = 0; i < no_of_bytes / 4; i++)
        {
            cache_block_array[i] = 0;
        }
    }

    ~cache_block()
    {
        delete[] cache_block_array;
    }
};

class cache_set_fifo
{
public:
    vector<cache_block *> *cache_set_queue;
    vector<bool> *dirty;
    vector<string> *tag;
    int size;

    cache_set_fifo()
    {
        cache_set_queue = new vector<cache_block *>;
        dirty = new vector<bool>;
        tag = new vector<string>;
        size = 0;
    }

    void load_of_set(string s)
    {
        int bits_for_line_cache = log2(no_of_bytes / 4);
        int bits_for_set = log2(no_of_sets);
        string tag_bits = s.substr(0, s.size() - 2 - bits_for_line_cache - bits_for_set);
        bool hit = false;
        for (int i = 0; i < size; i++)
        {
            if (tag->at(i) == tag_bits)
            {
                hit = true;
                break;
            }
        }
        if (hit == true)
        {
            load_hit++;
            total_hits++;
            total_cycles += 1;
        }
        else
        {
            load_miss++;
            total_miss++;
            if (size < no_of_blocks)
            {
                cache_block *temp = new cache_block();
                cache_set_queue->push_back(temp);
                dirty->push_back(false);
                tag->push_back(tag_bits);
                size++;
                total_cycles += (25 * no_of_bytes) + 1;
            }
            else
            {
                if (dirty->front() == false)
                {
                    total_cycles += (25 * no_of_bytes) + 1;
                }
                else
                {
                    total_cycles += (50 * no_of_bytes) + 1;
                }
                delete cache_set_queue->front();
                cache_set_queue->erase(cache_set_queue->begin());
                dirty->erase(dirty->begin());
                tag->erase(tag->begin());
                cache_block *temp = new cache_block();
                cache_set_queue->push_back(temp);
                dirty->push_back(false);
                tag->push_back(tag_bits);
            }
        }
    }

    void store_of_set(string s)
    {
        int bits_for_line_cache = log2(no_of_bytes / 4);
        int bits_for_set = log2(no_of_sets);
        string tag_bits = s.substr(0, s.size() - 2 - bits_for_line_cache - bits_for_set);
        bool hit = false;
        int where_found = 0;
        for (int i = 0; i < size; i++)
        {
            if (tag->at(i) == tag_bits)
            {
                hit = true;
                where_found = i;
                break;
            }
        }

        if (hit == true)
        {
            total_hits++;
            store_hit++;
            if (write_method == 1)
            {
                total_cycles += 101;
            }
            else
            {
                total_cycles += 1;
                dirty->at(where_found) = true;
            }
        }
        else
        {
            total_miss++;
            store_miss++;
            if (write_allocate == false)
            {
                total_cycles += 100;
            }
            else
            {
                if (size < no_of_blocks)
                {
                    cache_block *temp = new cache_block();
                    cache_set_queue->push_back(temp);
                    tag->push_back(tag_bits);
                    size++;
                    if (write_method == 1)
                    {
                        dirty->push_back(false);
                        total_cycles += 25 * no_of_bytes + 101;
                    }
                    else
                    {
                        dirty->push_back(true);
                        total_cycles += 25 * no_of_bytes + 1;
                    }
                }
                else
                {
                    if (dirty->front() == false)
                    {
                    }
                    else
                    {
                        total_cycles += 25 * no_of_bytes;
                    }
                    delete cache_set_queue->front();
                    cache_set_queue->erase(cache_set_queue->begin());
                    dirty->erase(dirty->begin());
                    tag->erase(tag->begin());
                    cache_block *temp = new cache_block();
                    cache_set_queue->push_back(temp);
                    tag->push_back(tag_bits);
                    if (write_method == 1)
                    {
                        dirty->push_back(false);
                        total_cycles += 25 * no_of_bytes + 101;
                    }
                    else
                    {
                        dirty->push_back(true);
                        total_cycles += 25 * no_of_bytes + 1;
                    }
                }
            }
        }
    }

    ~cache_set_fifo()
    {
        for (int i = 0; i < size; i++)
        {
            delete cache_set_queue->at(i);
        }
        delete cache_set_queue;
        delete dirty;
        delete tag;
    }
};

class cache_set_lru
{
public:
    vector<cache_block *> *cache_set_queue;
    vector<bool> *dirty;
    vector<string> *tag;
    int size;

    cache_set_lru()
    {
        cache_set_queue = new vector<cache_block *>;
        dirty = new vector<bool>;
        tag = new vector<string>;
        size = 0;
    }

    void load_of_set(string s)
    {
        int bits_for_line_cache = log2(no_of_bytes / 4);
        int bits_for_set = log2(no_of_sets);
        string tag_bits = s.substr(0, s.size() - 2 - bits_for_line_cache - bits_for_set);
        bool hit = false;
        int where_found = 0;
        for (int i = 0; i < size; i++)
        {
            if (tag->at(i) == tag_bits)
            {
                hit = true;
                where_found = i;
                break;
            }
        }
        if (hit == true)
        {
            load_hit++;
            total_hits++;
            total_cycles += 1;
            cache_set_queue->push_back(cache_set_queue->at(where_found));
            dirty->push_back(dirty->at(where_found));
            tag->push_back(tag->at(where_found));
            cache_set_queue->erase(cache_set_queue->begin() + where_found);
            dirty->erase(dirty->begin() + where_found);
            tag->erase(tag->begin() + where_found);
        }
        else
        {
            load_miss++;
            total_miss++;
            if (size < no_of_blocks)
            {
                cache_block *temp = new cache_block();
                cache_set_queue->push_back(temp);
                dirty->push_back(false);
                tag->push_back(tag_bits);
                size++;
                total_cycles += (25 * no_of_bytes) + 1;
            }
            else
            {
                if (dirty->front() == false)
                {
                    total_cycles += (25 * no_of_bytes) + 1;
                }
                else
                {
                    total_cycles += (50 * no_of_bytes) + 1;
                }
                delete cache_set_queue->front();
                cache_set_queue->erase(cache_set_queue->begin());
                dirty->erase(dirty->begin());
                tag->erase(tag->begin());
                cache_block *temp = new cache_block();
                cache_set_queue->push_back(temp);
                dirty->push_back(false);
                tag->push_back(tag_bits);
            }
        }
    }

    void store_of_set(string s)
    {
        int bits_for_line_cache = log2(no_of_bytes / 4);
        int bits_for_set = log2(no_of_sets);
        string tag_bits = s.substr(0, s.size() - 2 - bits_for_line_cache - bits_for_set);
        bool hit = false;
        int where_found = 0;
        for (int i = 0; i < size; i++)
        {
            if (tag->at(i) == tag_bits)
            {
                hit = true;
                where_found = i;
                break;
            }
        }

        if (hit == true)
        {
            total_hits++;
            store_hit++;
            if (write_method == 1)
            {
                total_cycles += 101;
            }
            else
            {
                total_cycles += 1;
                dirty->at(where_found) = true;
            }
            cache_set_queue->push_back(cache_set_queue->at(where_found));
            dirty->push_back(dirty->at(where_found));
            tag->push_back(tag->at(where_found));
            cache_set_queue->erase(cache_set_queue->begin() + where_found);
            dirty->erase(dirty->begin() + where_found);
            tag->erase(tag->begin() + where_found);
        }
        else
        {
            total_miss++;
            store_miss++;
            if (write_allocate == false)
            {
                total_cycles += 100;
            }
            else
            {
                if (size < no_of_blocks)
                {
                    cache_block *temp = new cache_block();
                    cache_set_queue->push_back(temp);
                    tag->push_back(tag_bits);
                    size++;
                    if (write_method == 1)
                    {
                        dirty->push_back(false);
                        total_cycles += 25 * no_of_bytes + 101;
                    }
                    else
                    {
                        dirty->push_back(true);
                        total_cycles += 25 * no_of_bytes + 1;
                    }
                }
                else
                {
                    if (dirty->front() == false)
                    {
                    }
                    else
                    {
                        total_cycles += 25 * no_of_bytes;
                    }
                    delete cache_set_queue->front();
                    cache_set_queue->erase(cache_set_queue->begin());
                    dirty->erase(dirty->begin());
                    tag->erase(tag->begin());
                    cache_block *temp = new cache_block();
                    cache_set_queue->push_back(temp);
                    tag->push_back(tag_bits);
                    if (write_method == 1)
                    {
                        dirty->push_back(false);
                        total_cycles += 25 * no_of_bytes + 101;
                    }
                    else
                    {
                        dirty->push_back(true);
                        total_cycles += 25 * no_of_bytes + 1;
                    }
                }
            }
        }
    }

    ~cache_set_lru()
    {
        for (int i = 0; i < size; i++)
        {
            delete cache_set_queue->at(i);
        }
        delete cache_set_queue;
        delete dirty;
        delete tag;
    }
};

class cache
{
public:
    cache_set_fifo **cache_array_fifo;
    cache_set_lru **cache_array_lru;

    cache()
    {
        if (lru_or_fifo == "lru")
        {
            cache_array_lru = new cache_set_lru *[no_of_sets];

            for (int i = 0; i < no_of_sets; i++)
            {
                cache_set_lru *temp = new cache_set_lru();
                cache_array_lru[i] = temp;
            }
        }
        else
        {
            cache_array_fifo = new cache_set_fifo *[no_of_sets];

            for (int i = 0; i < no_of_sets; i++)
            {
                cache_set_fifo *temp = new cache_set_fifo();
                cache_array_fifo[i] = temp;
            }
        }
    }

    void load_of_cache(string s)
    {
        total_loads++;
        int bits_for_line_cache = log2(no_of_bytes / 4);
        int bits_for_set = log2(no_of_sets);
        string set_bits = s.substr(s.length() - 2 - bits_for_set - bits_for_line_cache, bits_for_set);
        int set_number;
        if (set_bits == "")
        {
            set_number = 0;
        }
        else
        {
            set_number = stoi(set_bits, nullptr, 2);
        }
        if (lru_or_fifo == "lru")
        {
            cache_array_lru[set_number]->load_of_set(s);
        }
        else
        {
            cache_array_fifo[set_number]->load_of_set(s);
        }
    }

    void store_of_cache(string s)
    {
        total_stores++;
        int bits_for_line_cache = log2(no_of_bytes / 4);
        int bits_for_set = log2(no_of_sets);
        string set_bits = s.substr(s.length() - 2 - bits_for_set - bits_for_line_cache, bits_for_set);
        int set_number;
        if (set_bits == "")
        {
            set_number = 0;
        }
        else
        {
            set_number = stoi(set_bits, nullptr, 2);
        }
        if (lru_or_fifo == "lru")
        {
            cache_array_lru[set_number]->store_of_set(s);
        }
        else
        {
            cache_array_fifo[set_number]->store_of_set(s);
        }
    }

    ~cache()
    {
        if (lru_or_fifo == "lru")
        {
            for (int i = 0; i < no_of_sets; i++)
            {
                delete cache_array_lru[i];
            }
            delete[] cache_array_lru;
        }
        else
        {
            for (int i = 0; i < no_of_sets; i++)
            {
                delete cache_array_fifo[i];
            }
            delete[] cache_array_fifo;
        }
    }
};

int main(int argc, char *argv[])
{
    {
        if (argc != 7)
        {
            cout << "error in number of inputs" << endl;
            return 0;
        }
        no_of_sets = stoi(argv[1]);
        no_of_blocks = stoi(argv[2]);
        no_of_bytes = stoi(argv[3]);

        string policy;
        policy = argv[4];

        if (policy == "write-allocate")
        {
            write_allocate = true;
        }
        else if (policy == "no-write-allocate")
        {
            write_allocate = false;
        }
        else
        {
            cout << "error in input";
            return 0;
        }

        policy = argv[5];

        if (policy == "write-through")
        {
            write_method = 1;
        }
        else if (policy == "write-back")
        {
            write_method = 0;
        }
        else
        {
            cout << "error in input";
            return 0;
        }

        policy = argv[6];

        if (policy == "lru")
        {
            lru_or_fifo = "lru";
        }
        else if (policy == "fifo")
        {
            lru_or_fifo = "fifo";
        }
        else
        {
            cout << "error in input";
            return 0;
        }
    }

    cache *my_cache = new cache();
    string x, y, z;
    ;
    while (cin >> x >> y >> z)
    {
        y = y.substr(2);
        while (y.size() < 8)
        {
            y = "0" + y;
        }
        y = hexToBinary(y);
        if (x == "l")
        {
            my_cache->load_of_cache(y);
        }
        else
        {
            my_cache->store_of_cache(y);
        }
    }

    cout << "Total loads: " << total_loads << endl;
    cout << "Total stores: " << total_stores << endl;
    cout << "Load hits: " << load_hit << endl;
    cout << "Load misses: " << load_miss << endl;
    cout << "Store hits: " << store_hit << endl;
    cout << "Store misses: " << store_miss << endl;
    cout << "Total cycles: " << total_cycles << endl;

    delete my_cache;
    return 0;
}