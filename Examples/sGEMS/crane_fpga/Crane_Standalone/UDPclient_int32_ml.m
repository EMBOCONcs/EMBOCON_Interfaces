function [aa,bb] = UDPclient_int_ml(din)


% Sizes of input and output buffers
dbinsize = int32(17);
dboutsize = int32(2);

eTime = double(0);

%coder.typeof(char('a'), [1, 100], 1)

hname1 = [char('192.168.1.10'), char(0)];

% Allocate memory for return function
doutbuffer = double(zeros(dboutsize,1));

% Call C function
rr = uint32(0);
rr = coder.ceval('UDPclient_combined', ...
    coder.rref(hname1), ...
    coder.rref(din), ...
    coder.wref(doutbuffer), ...
    dbinsize, ...
    dboutsize, ...
    coder.wref(eTime));
    
% Handle errors for debugging purposes
if rr ~=0    
    switch rr
        case 1
            error('WSA failed to be initialised');
        case 2
            error('No such host');
        case 3
            error('Error opening socket');
        case 4
            error('Send failed');
        case 5
            error('Receive failed');
        case 6
            error('Time out');
        otherwise
    end
end

% Cast back to MATLAB native representation
aa = double(doutbuffer);

bb = double(0);
bb = eTime;

