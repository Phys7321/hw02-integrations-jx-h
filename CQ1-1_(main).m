close all
potential_order = 4;

a_array = logspace(-20, 10, 1e2);
t_array = zeros(size(a_array));
for i_a = 1:numel(a_array)
    a = a_array(i_a);
    f_a = @(x) 1./sqrt(a^potential_order - x.^potential_order);
    t_array(i_a) = 2*sqrt(2)*integral(f_a, 0, a);
end

loglog(a_array, t_array, 'bo')
hold on
at_fit = polyfit(log(a_array), log(t_array), 1);
loglog(a_array, exp(at_fit(2))*a_array.^at_fit(1), 'r-')
title({['$T \propto a^{', num2str(at_fit(1), 3), '} \propto  $ a to the power of (1 - potential~order/2)'], ...
    'Reason: the 1 comes from dx, -order/2 comes from the denominator', ...
    'By sub y=x/a, we have a constant integral for all a', ...
    'and the pre factor has $a^{1-order/2}$ due to this substitution'}, 'interpreter', 'latex')
xlabel('a')
ylabel('T')



