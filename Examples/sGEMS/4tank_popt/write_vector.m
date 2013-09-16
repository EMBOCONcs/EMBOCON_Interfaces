function write_vector(f,A)
fwrite(f,size(A,1)*size(A,2),'ulong');
fwrite(f,A,'double');