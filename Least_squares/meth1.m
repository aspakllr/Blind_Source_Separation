function [Sa_out, Sk_out] = meth1(x, Saf, Skf, samples)

Aa = [1 2;2 1];
A = inv(Aa);

for n=1:samples
Sa_out(1,n) = A(1,1)*(x(n)+Skf(n)) + A(1,2)* (x(n)+Saf(n));
Sk_out(1,n) = A(2,1)*(x(n)+Skf(n)) + A(2,2)* (x(n)+Saf(n));
end

figure()
subplot(2,1,1);plot(Sa_out,'color',[0.502 0.502 1]);title('Method 1');xlim([0 samples]);
subplot(2,1,2);plot(Sk_out,'color',[0.502 0 0]);xlim([0 samples]);

end
