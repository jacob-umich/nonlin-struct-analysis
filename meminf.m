function [length, angle] = meminf(x1, y1, x2, y2)

% calculate the length of the member

length = sqrt((x2 - x1)^2 + (y2 - y1)^2);

% calculate the angle of rotation

deltax = (x2 - x1);
deltay = (y2 - y1);

angle = atan2(deltay, deltax);

