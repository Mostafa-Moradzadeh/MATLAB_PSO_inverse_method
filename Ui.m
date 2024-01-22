function y=Ui(t)
global Intensity Rainfallduration
if t<=Rainfallduration && t>0
    y=Intensity;
else y=0;
end