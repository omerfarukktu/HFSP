
numberofjobs=[10 20 30 40]; %numberoflots

numberofsublot= [2 6 10];

numberofstages=[2 6 10];

asamamakinesayisi= [4 6 8]; %numberofmachines

for zz=1:4
    if zz==1
        numberofjobs=10; %numberoflots
        maxizinverilengecikme=10000; %allowed waiting time
    elseif zz==2
        numberofjobs=20; %numberoflots
        maxizinverilengecikme=30000; %allowed waiting time
    elseif zz==3
        numberofjobs=30; %numberoflots 
        maxizinverilengecikme=60000; %allowed waiting time
    elseif zz==4
        numberofjobs=40; %numberoflots
        maxizinverilengecikme=90000; %allowed waiting time
    end
    for z=1:27
        if z==1
            numberofsublot=4;
            numberofstages=2;
            asamamakinesayisi=4; %numberofmachines
        elseif z==2
            numberofsublot=4;
            numberofstages=2;
            asamamakinesayisi=6; %numberofmachines
        elseif z==3
            numberofsublot=4;
            numberofstages=2;
            asamamakinesayisi=8; %numberofmachines
        elseif z==4
            numberofsublot=4;
            numberofstages=3;
            asamamakinesayisi=4; %numberofmachines
        elseif z==5
            numberofsublot=4;
            numberofstages=3;
            asamamakinesayisi=6; %numberofmachines
        elseif z==6
            numberofsublot=4;
            numberofstages=3;
            asamamakinesayisi=8; %numberofmachines
        elseif z==7
            numberofsublot=4;
            numberofstages=4;
            asamamakinesayisi=4; %numberofmachines
        elseif z==8
            numberofsublot=4;
            numberofstages=4;
            asamamakinesayisi=6; %numberofmachines
        elseif z==9
            numberofsublot=4;
            numberofstages=4;
            asamamakinesayisi=8; %numberofmachines
        elseif z==10
            numberofsublot=8;
            numberofstages=2;
            asamamakinesayisi=4; %numberofmachines
        elseif z==11
            numberofsublot=8;
            numberofstages=2;
            asamamakinesayisi=6; %numberofmachines
        elseif z==12
            numberofsublot=8;
            numberofstages=2;
            asamamakinesayisi=8; %numberofmachines
        elseif z==13
            numberofsublot=8;
            numberofstages=3;
            asamamakinesayisi=4; %numberofmachines
        elseif z==14
            numberofsublot=8;
            numberofstages=3;
            asamamakinesayisi=6; %numberofmachines
        elseif z==15
            numberofsublot=8;
            numberofstages=3;
            asamamakinesayisi=8; %numberofmachines
        elseif z==16
            numberofsublot=8;
            numberofstages=4;
            asamamakinesayisi=4; %numberofmachines
        elseif z==17
            numberofsublot=8;
            numberofstages=4;
            asamamakinesayisi=6; %numberofmachines
        elseif z==18
            numberofsublot=8;
            numberofstages=4;
            asamamakinesayisi=8; %numberofmachines
        elseif z==19
            numberofsublot=16;
            numberofstages=2;
            asamamakinesayisi=4; %numberofmachines
        elseif z==20
            numberofsublot=16;
            numberofstages=2;
            asamamakinesayisi=6; %numberofmachines
        elseif z==21
            numberofsublot=16;
            numberofstages=2;
            asamamakinesayisi=8; %numberofmachines
        elseif z==22
            numberofsublot=16;
            numberofstages=3;
            asamamakinesayisi=4; %numberofmachines
        elseif z==23
            numberofsublot=16;
            numberofstages=3;
            asamamakinesayisi=6; %numberofmachines
        elseif z==24
            numberofsublot=16;
            numberofstages=3;
            asamamakinesayisi=8; %numberofmachines
        elseif z==25
            numberofsublot=16;
            numberofstages=4;
            asamamakinesayisi=4; %numberofmachines
        elseif z==26
            numberofsublot=16;
            numberofstages=4;
            asamamakinesayisi=6; %numberofmachines
        elseif z==27
            numberofsublot=16;
            numberofstages=4;
            asamamakinesayisi=8; %numberofmachines
        end

        for i=1:numberofjobs
            for j=1:numberofstages*asamamakinesayisi %numberofmachines
                if (rand>0.5)
                    mam(i,j)=1;
                else
                    mam(i,j)=0;
                end
            end
        end
        mam(randi(numberofjobs),find(sum(mam)==0))=1;

        for i=1:numberofstages
            aka=mam(:,asamamakinesayisi*i-(asamamakinesayisi-1):asamamakinesayisi*i)';
            aka(randi(asamamakinesayisi),find(sum(aka)==0))=1;
            mam(:,asamamakinesayisi*i-(asamamakinesayisi-1):asamamakinesayisi*i)=aka';
        end

        pt=mam;
        for i=1:numberofjobs
            for j=1:numberofstages*asamamakinesayisi %numberofmachines
                if (pt(i,j)==1)
                    pt(i,j)= 10 + (20-10)*rand();
                else
                    pt(i,j)=0;
                end
            end
        end

        ss=[32 64 96];
        ls(1:size(mam,1),1)=ss(randi(3));
        tnumberofsublot=numberofsublot*size(mam,1);

        mam2=mam;
        pt2=pt;
        ls2=ls/numberofsublot; 
        for i=2:numberofsublot
            mam2=[mam2; mam];
            pt2=[pt2; pt];
            ls2=[ls2; ls/numberofsublot];
        end
        population_size=numberofjobs*6;

        ls3=zeros(size(ls2,1),population_size);
        for i=1:population_size
            tyy=[];
            for ii=1:numberofjobs
                m=1:ls(1);
                a=m(sort(randperm(ls(1),numberofsublot)));
                b=diff(a);
                b(end+1)=ls(1)-sum(b);
                ty=b';
                tyy=[tyy; ty];
            end
            ls3(:,i)=tyy;
        end
        crprob=0.8;
        numberofelitistindividuals=0.05;
        iteration_number=300+numberofjobs*10;

        [P,pobje] = geneticflowshopcr1ea(tnumberofsublot,mam2,pt2,ls2,population_size,iteration_number,numberofjobs,numberofsublot,numberofstages,asamamakinesayisi,crprob,numberofelitistindividuals,maxizinverilengecikme);
        pobje1=pobje;
        [P,pobje] = geneticflowshopcr2ea(tnumberofsublot,mam2,pt2,ls2,population_size,iteration_number,numberofjobs,numberofsublot,numberofstages,asamamakinesayisi,crprob,numberofelitistindividuals,maxizinverilengecikme);
        pobje2=pobje;
        [P,pobje] = geneticflowshopcr2ra(tnumberofsublot,mam2,pt2,ls3,population_size,iteration_number,numberofjobs,numberofsublot,numberofstages,asamamakinesayisi,crprob,numberofelitistindividuals,maxizinverilengecikme);
        pobje3=pobje;
        [P,pobje] = geneticflowshopcr1ra(tnumberofsublot,mam2,pt2,ls3,population_size,iteration_number,numberofjobs,numberofsublot,numberofstages,asamamakinesayisi,crprob,numberofelitistindividuals,maxizinverilengecikme);
        pobje4=pobje;

        [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,drr1,drr2,drr3,drr4,OS12,OS13,OS14,OS23,OS24,OS34,Nnd1,Nnd2,Nnd3,Nnd4, Nnd5, Nnd6, Nnd7, Nnd8] = metrics(pobje1,pobje2,pobje3,pobje4)


        %d1 C(pobj1,pobje2) ; d2 C(pobje2, pobje1); ....
        Cmetric(z,:,zz)=[d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12]
        Dmetric(z,:,zz)=[drr1 drr2 drr3 drr4]
        OSmetric(z,:,zz)=[OS12 OS13 OS14 OS23 OS24 OS34]
        Nndmetric(z,:,zz)=[Nnd1 Nnd2 Nnd3 Nnd4 Nnd5 Nnd6 Nnd7 Nnd8]
    end
end