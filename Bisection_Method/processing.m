## Copyright (C) 2016 Pritika
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} processing (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Pritika <pritika@pritika-Inspiron-3543>
## Created: 2016-02-25

function [x3,iteration] = processing (p,x1, x2)
iteration=0;
p1=polynomial(p,x1);
p2=polynomial(p,x2); 
if(p1*p2>0)
"no root between these points"
endif
while(abs(x1-x2)> 0.00001)
    x3 = (x1 +x2)/2;
    x3
    iteration=iteration+1;
    p3=polynomial(p,x3);
    if (p1 * p3 < 0)
        x2 = x3;
        p2 = p3;
     else
     x1 = x3;
     p1 = p3;
    end
end
endfunction
