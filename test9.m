close all
dist_case = 3;

if dist_case == 1
    f = @(x, y, z, charge_x) 2*charge_x./sqrt((x-charge_x).^2 + y.^2 + z.^2);
    V = @(x, y, z) integral(@(charge_x) f(x, y, z, charge_x), 0, 1);
    z = 0.5;
elseif dist_case == 2
    f1 = @(x, y, z, charge_x) charge_x.^2./sqrt((x-charge_x).^2 + y.^2 + z.^2);
    f2 = @(x, y, z, charge_y) charge_y./sqrt((y-charge_y).^2 + x.^2 + z.^2);
    V = @(x, y, z) integral(@(charge_x) f1(x, y, z, charge_x), 0, 1) + ...
        integral(@(charge_y) f2(x, y, z, charge_y), 1, 2);
    z = 0.5;
elseif dist_case == 3
    f = @(x, y, z, charge_r, charge_phi) x./sqrt((x-charge_r.*cos(charge_phi)).^2 ...
        + (y-charge_r.*sin(charge_phi)).^2 + z.^2);
    V = @(x, y, z) integral2(@(charge_r, charge_phi) f(x, y, z, charge_r, charge_phi), 0, 2, 0, 2*pi);
    z = 0.5;
end

step_number = 20;
xx = linspace(-3, 3, step_number);
yy = linspace(-3, 3, step_number);

potential = zeros(step_number, step_number);
for i = 1:step_number
    for j = 1:step_number
        potential(i,j) = V(yy(j), xx(i), z);
    end
end

figure
surf(xx,yy,potential)

figure
[Ex, Ey] = gradient(potential);
Ex_n = -Ex./sqrt(Ex.^2+Ey.^2);
Ey_n = -Ey./sqrt(Ex.^2+Ey.^2);
contour(xx, yy, potential, floor(step_number/2))
hold on
quiver(xx, yy, Ex_n, Ey_n)