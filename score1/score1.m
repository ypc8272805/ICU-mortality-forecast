function [score]=score1(IHDc,DATAc)
TPc=sum(DATAc(IHDc==1,1));
FNc=sum(~DATAc(IHDc==1,1));
FPc=sum(DATAc(IHDc==0,1));  
TNc=sum(~DATAc(IHDc==0,1));  
Tec=TNc/(TNc+FPc);
Sec=TPc/(TPc+FNc);
PPVc=TPc/(TPc+FPc);
score = min(Se, PPV);
end