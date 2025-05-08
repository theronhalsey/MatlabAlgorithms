function rand_n = randInt(max)

r_int = uint64(randi(intmax));
rand_big = uint64(r_int * max);
rand_n = bitshift(rand_big,-31,"uint64") + 1;

end