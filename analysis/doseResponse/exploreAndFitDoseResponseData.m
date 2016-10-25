% explore and fit dose response data
% aggregate all serotypes

close all; clear all;

addpath(genpath('..\helperFunctions'));
addpath(genpath('..\..\data\doseResponse'));

data=doseResponseData();

%% show all data

modelDoseRange=logspace(-1,6,1e4);
cmap=[[125,0,0];[175,0,0]; ...
    [150,125,0];[0,175,0];[0,225,0]; ...
    [0,0,125];[0,0,175]; [0,0,225];[0,50,150];[125,0,125] ...
    ]/255;

% main paper figure

% figure(1) mOPV challenge studies
figure(1)
clf;

% set(gcf,'Units','inches','Position',[0 0 7.5 3.5])

subplot(3,2,[1,3])
A1=gca;
hold all


plot(data.Minor1981.smooth.dose,data.Minor1981.smooth.pos./data.Minor1981.smooth.N,':o','linewidth',1,'color',cmap(1,:))
hl={'unvaccinated; age 2 m'}; 

plot(data.Henry1966.dose,data.Henry1966.unvaccinated.pos./data.Henry1966.unvaccinated.N,':d','linewidth',1,'color',cmap(2,:))
hl{end+1}='unvaccinated; age 6 m';

plot(data.Henry1966.dose*0.9,data.Henry1966.IPVx3.pos./data.Henry1966.IPVx3.N,'-d','linewidth',1,'color',cmap(3,:))
hl{end+1}='IPVx3; 2,3,4 m; age 6 m'; 

plot(data.Henry1966.dose*1.1,data.Henry1966.IPVx4.pos./data.Henry1966.IPVx4.N,'-d','linewidth',1,'color',cmap(4,:))
hl{end+1}='IPVx4, 2,3,4,15 m; age 16 m'; 

plot(data.Onorato1991.dose,data.Onorato1991.IPVx3.pos./data.Onorato1991.IPVx3.N,'-s','linewidth',1,'color',cmap(5,:))
hl{end+1}='IPVx3, 2,3,18 m; age 27 m'; 

plot(data.Henry1966.dose,data.Henry1966.tOPVx3.pos./data.Henry1966.tOPVx3.N,'--d','linewidth',1,'color',cmap(6,:))
hl{end+1}='tOPVx3; 7,8,9 m; age 16 m'; % earlier tOPV formulation, no booster

plot(data.Onorato1991.dose,data.Onorato1991.tOPVx3.pos./data.Onorato1991.tOPVx3.N,'s--','linewidth',1,'color',cmap(7,:))
hl{end+1}='tOPVx3, 2,4,18 m; age 24 m'; 

plot(data.Jafari2014.dose(3),data.Jafari2014.tOPVxN.pos(3)./data.Jafari2014.tOPVxN.N(3),'.','linewidth',1,'color',cmap(8,:),'markersize',10)
hl{end+1}='tOPVxN; age 10 y'; 

% plot(data.Jafari2014.dose(1),data.Jafari2014.bOPVboost.pos(1)./data.Jafari2014.bOPVboost.N(1),'.','linewidth',1,'color',cmap(9,:),'markersize',10)
% hl{end+1}='tOPV, bOPV boost 12 months; age 13 months'; 

plot(data.Jafari2014.dose(3),data.Jafari2014.IPVboost.pos(3)./data.Jafari2014.IPVboost.N(3),'.','linewidth',1,'color',cmap(10,:),'markersize',10)
hl{end+1}='tOPVxN & IPV boost, 10 y; age 10 y'; 


title('Sabin 1','fontweight','normal')

L1=legend(hl,'location','SouthOutside');
set(legend,'fontsize',7)
set(gca,'xscale','log')
hold all
xlabel('dose [TCID50]')
ylabel('fraction shedding')
box off
ylim([-0.01,1.01])
set(gca,'xtick',10.^[-3:2:6])
xlim(modelDoseRange([1,end]))

axisPos=get(gca,'pos');

% type 2 challenge studies
subplot(3,2,[2,4])
A2=gca;
hold all

cmap(11,:)=[0.2 0.2 0.2 ];
plot(data.Dane1961.unvaccinated.Sabin2.dose,data.Dane1961.unvaccinated.Sabin2.pos./data.Dane1961.unvaccinated.Sabin2.N,':*','linewidth',1,'color',cmap(11,:))
hl{end+1}='unvaccinated; age 11 m'; 

cmap(12,:)=[0.5, 0.5, 0.5];
plot(data.Dane1961.unvaccinated.HumanPassaged5DayStool.dose,data.Dane1961.unvaccinated.HumanPassaged5DayStool.pos./data.Dane1961.unvaccinated.HumanPassaged5DayStool.N,':*','linewidth',1,'color',cmap(12,:))
hl{end+1}='unvaccinated; (human-passaged); age 11 m'; 

cmap(13,:)=cmap(3,:);
plot(data.ORyan2015.dose*0.9,data.ORyan2015.IPVx3.pos./data.ORyan2015.IPVx3.N,'d','markersize',5,'color',cmap(3,:),'markerfacecolor',cmap(3,:))
hl{end+1}='IPVx3; 6,10,14 w; age 6 m'; 

cmap(14,:)=[125,0,150]/255;
plot(data.ORyan2015.dose*0.9,data.ORyan2015.IPVx1bOPVx2.pos./data.ORyan2015.IPVx1bOPVx2.N,'d','markersize',5,'color',[125,0,150]/255,'markerfacecolor',cmap(14,:))
hl{end+1}='IPVx1 &bOPVx2; 6,10,14 w; age 6 m';

cmap(15,:)=[175,0,125]/255;
plot(data.ORyan2015.dose*0.9,data.ORyan2015.IPVx2bOPVx1.pos./data.ORyan2015.IPVx2bOPVx1.N,'d','markersize',5,'color',[175,0,125]/255,'markerfacecolor',cmap(15,:))
hl{end+1}='IPVx2 & bOPVx1; 6,10,15 w; age 6 m'; 

cmap(16,:)=[0,50,125]/255;
plot(data.Asturias2016.dose,data.Asturias2016.bOPVx3.pos./data.Asturias2016.bOPVx3.N,'.','markersize',10,'color',cmap(16,:))
hl{end+1}='bOPVx3; 6,10,14 w; age 4 m'; 

cmap(17,:)=[150,0,125]/255;
plot(data.Asturias2016.dose,data.Asturias2016.bOPVx3IPVx1.pos./data.Asturias2016.bOPVx3IPVx1.N,'.','markersize',10,'color',cmap(17,:))
hl{end+1}='bOPVx3 & IPVx1; 6,10,14 w; age 4 m';

cmap(18,:)=cmap(2,:);
plot(data.Asturias2016.dose,data.Asturias2016.tOPVx3.pos./data.Asturias2016.tOPVx3.N,'.','markersize',10,'color',cmap(2,:))
hl{end+1}='tOPVx3; 6,10,14 w; age 4 m';

title('Sabin 2','fontweight','normal')
L2=legend(hl(end-7:end),'location','SouthOutside');
set(legend,'fontsize',7)
set(gca,'xscale','log')
hold all
xlabel('dose [TCID50]')
ylabel('fraction shedding')
box off
ylim([-0.01,1.01])
set(gca,'xtick',10.^[-3:2:6])
xlim(modelDoseRange([1,end]))

drawnow();

pos=get(gca,'pos');
pos(2)=axisPos(2); pos(4)=axisPos(4);
set(gca,'pos',pos);



%% mucosal-naive dose response and model

% plot naive type 1
subplot(3,3,8)
hold on;
plot(data.Minor1981.smooth.dose,data.Minor1981.smooth.pos./data.Minor1981.smooth.N,'-','color',cmap(1,:))
plot(data.Henry1966.dose,data.Henry1966.unvaccinated.pos./data.Henry1966.unvaccinated.N,'-','color',cmap(2,:))
plot(data.Henry1966.dose,data.Henry1966.IPVx3.pos./data.Henry1966.IPVx3.N ,'-','color',cmap(3,:))

% aggregate type 2
plot(data.Dane1961.unvaccinated.Sabin2.dose,data.Dane1961.unvaccinated.Sabin2.pos./data.Dane1961.unvaccinated.Sabin2.N,'-','color',cmap(11,:))
plot(data.Dane1961.unvaccinated.HumanPassaged5DayStool.dose,data.Dane1961.unvaccinated.HumanPassaged5DayStool.pos./data.Dane1961.unvaccinated.HumanPassaged5DayStool.N,'-','color',cmap(12,:))

set(gca,'xscale','log')
xlim([modelDoseRange(1),modelDoseRange(end)])
set(gca,'xtick',10.^[-3:2:6])
xlabel('dose [TCID50]')
ylabel('fraction shedding')

%% fit all naive
X=[data.Minor1981.dose, data.Henry1966.dose,data.Henry1966.dose ...
    data.Dane1961.unvaccinated.Sabin2.dose, data.Dane1961.unvaccinated.HumanPassaged5DayStool.dose]';
Y=[data.Minor1981.pos,data.Henry1966.unvaccinated.pos,data.Henry1966.IPVx3.pos ...
    data.Dane1961.unvaccinated.Sabin2.pos,data.Dane1961.unvaccinated.HumanPassaged5DayStool.pos]';
N=[data.Minor1981.N,data.Henry1966.unvaccinated.N,data.Henry1966.IPVx3.N ...
    data.Dane1961.unvaccinated.Sabin2.N,data.Dane1961.unvaccinated.HumanPassaged5DayStool.N]';

[beta,CI,naiveYCI]=doseResponseBootstrapFitter(X,Y,N,1000,modelDoseRange,1);

% plot fit
plotWithCI(modelDoseRange,doseResponseModel(modelDoseRange,1,1,[beta(1),beta(2),0]),naiveYCI,[0.,0.,0])

% HID50
HID50=fsolve(@(x) doseResponseModel(x,1,1,[beta(1),beta(2),0])-0.5,10)
HID50CI(2)=modelDoseRange(find(naiveYCI(:,1)>=0.5,1));
HID50CI(1)=modelDoseRange(find(naiveYCI(:,2)>=0.5,1))

%% immunity vs vaccine take, fit alpha vs logNab

% get immunities
addpath(genpath('..\..\analysis\shedding'));
shedData = loadSheddingDurationData();

% combine all naive
[numImmDat,~,immDat]=xlsread('..\..\analysis\shedding\fitImmunityAllSheddingCDFs.csv');
idx=ismember(immDat(:,1),{'seronegative','unvaccinated'}); idx=idx(2:end);
immunizationPlans={'naive'};

NAb=2^(sum(log2(numImmDat(idx,2).*numImmDat(idx,end)))/sum(numImmDat(idx,end)));
    sem=mean((log2(numImmDat(idx,4))-log2(numImmDat(idx,3)))/4)/sqrt(sum(numImmDat(idx,end)));
NAbCI=2.^([log2(NAb)-2*sem,log2(NAb)+2*sem]);

vaccineTake=doseResponseModel(10^5.7,1);
vaccineTakeCI=naiveYCI(find(modelDoseRange>=10^5.7,1),:);
sampleSize=sum(numImmDat(idx,end));

% find appropriate study groups by immune status
immunizationPlans(end+(1:4))={'bOPVx3 & IPVx1','bOPVx3 & IPVx2','IPVx2 & bOPVx1','IPVx1 & bOPVx2'};
idx=ismember(immDat(:,1),immunizationPlans); idx=idx(2:end);

NAb(end+(1:4),1)=nan;
NAbCI(end+(1:4),:)=nan;
NAb(2:5)=numImmDat(idx,2);
NAbCI(2:5,:)=numImmDat(idx,3:4);

[vaccineTake(2,1),vaccineTakeCI(2,:)]=binofit(data.Asturias2016.bOPVx3IPVx1.pos,data.Asturias2016.bOPVx3IPVx1.N);
[vaccineTake(3,1),vaccineTakeCI(3,:)]=binofit(data.Asturias2016.bOPVx3IPVx2.pos,data.Asturias2016.bOPVx3IPVx2.N);
[vaccineTake(4,1),vaccineTakeCI(4,:)]=binofit(data.ORyan2015.IPVx2bOPVx1.pos,data.ORyan2015.IPVx2bOPVx1.N);
[vaccineTake(5,1),vaccineTakeCI(5,:)]=binofit(data.ORyan2015.IPVx1bOPVx2.pos,data.ORyan2015.IPVx1bOPVx2.N);
sampleSize(2,1)=data.Asturias2016.bOPVx3IPVx1.N;
sampleSize(3,1)=data.Asturias2016.bOPVx3IPVx2.N;
sampleSize(4,1)=data.ORyan2015.IPVx2bOPVx1.N;
sampleSize(5,1)=data.ORyan2015.IPVx1bOPVx2.N;

% add specific trial arms
author={'Henry','Henry','Onorato','Onorato','Asturias','Asturias'};
immPlan={'tOPVx3','IPVx4','tOPVx3','IPVx3','tOPVx3','bOPVx3'};
idx=find(ismember(shedData.author,author)&ismember(shedData.primaryImmunization,immPlan)&~(ismember(shedData.author,{'Henry'})&ismember(shedData.primaryImmunization,{'IPVx3'})));
immunizationPlans(end+(1:length(idx)))=shedData.primaryImmunization(idx);

for k=1:length(idx);
    X=shedData.daysSinceChallenge';
    Y=shedData.sheddingCDF(idx(k),:)';
    N=repmat(shedData.sampleSize(idx(k)),length(Y),1);
    [NAb(5+k),NAbCI(5+k,:)]=sheddingDurationCDFbootstrapFitter(X,Y,N,100);
end

[vaccineTake(6,1),vaccineTakeCI(6,:)]=binofit(data.Henry1966.IPVx4.pos(1),data.Henry1966.IPVx4.N(1));
[vaccineTake(7,1),vaccineTakeCI(7,:)]=binofit(data.Henry1966.tOPVx3.pos(1),data.Henry1966.tOPVx3.N(1));
[vaccineTake(8,1),vaccineTakeCI(8,:)]=binofit(data.Onorato1991.IPVx3.pos(1),data.Onorato1991.IPVx3.N(1));
[vaccineTake(9,1),vaccineTakeCI(9,:)]=binofit(data.Onorato1991.tOPVx3.pos(1),data.Onorato1991.tOPVx3.N(1));
[vaccineTake(10,1),vaccineTakeCI(10,:)]=binofit(data.Asturias2016.bOPVx3.pos(1),data.Asturias2016.bOPVx3.N(1));
[vaccineTake(11,1),vaccineTakeCI(11,:)]=binofit(data.Asturias2016.tOPVx3.pos,data.Asturias2016.tOPVx3.N);
[vaccineTake(12,1),vaccineTakeCI(12,:)]=binofit(data.Asturias2016.bOPVx3.pos(2),data.Asturias2016.bOPVx3.N(2));
sampleSize(6,1)=data.Henry1966.IPVx4.N(1);
sampleSize(7,1)=data.Henry1966.tOPVx3.N(1);
sampleSize(8,1)=data.Onorato1991.IPVx3.N(1);
sampleSize(9,1)=data.Onorato1991.tOPVx3.N(1);
sampleSize(10,1)=data.Asturias2016.bOPVx3.N(1);
sampleSize(11,1)=data.Asturias2016.tOPVx3.N;
sampleSize(12,1)=data.Asturias2016.bOPVx3.N(2);

%% plot
subplot(3,3,7)
cmap=cmap([1,17,17,15,14,4,6,5,7,16,18,16],:);
cmap(3,:)=cmap(3,:)*1.1;
cmap(12,:)=cmap(12,:)*1.2;

hold on;
for k=1:length(NAb)
    plot(NAb(k),vaccineTake(k),'.','markerfacecolor',cmap(k,:),'markeredgecolor',cmap(k,:),'markersize',10);
    plot(NAb(k)*[1,1],vaccineTakeCI(k,:),'-','color',cmap(k,:));
    plot(NAbCI(k,:),vaccineTake(k)*[1,1],'-','color',cmap(k,:));
end
set(gca,'xscale','log')
xlim([.1,2^14])
set(gca,'xtick',10.^[-3:2:6])
xlabel('OPV-equivalent antibody titer')
ylabel('vaccine take')
colormap(cmap);

h=colorbar;
set(h,'ytick',(0.5+[0:length(immunizationPlans)])/length(immunizationPlans),'yticklabel',immunizationPlans)

%% fit model
[NAbBeta,NAbBetaCI,yCI]=antibodyDependenceDoseResponseBootstrapFitter(NAb,vaccineTake,sampleSize,beta,CI,100);

NAbRange=logspace(0,log10(2^14),1000);
plotWithCI(NAbRange,doseResponseModel(10^5.7,NAbRange,[beta(1),beta(2),NAbBeta]),yCI,[0.2,0.2,0.2])

%% plot model
subplot(3,3,9)
cmap2=colormap(lines(4));
cmap2(2:4,:)=cmap2([1,2,4],:);
cmap2(1,:)=[.2,.2,.2];
hold on;

% naive
plotWithCI(modelDoseRange,doseResponseModel(modelDoseRange,1,1,[beta(1),beta(2),0]),naiveYCI,cmap2(1,:))

% NAb=8
NAb=2^3;
reps=100;
betaCI(:,1)=linspace(CI(1,1),CI(2,1),reps);
betaCI(:,2)=linspace(CI(1,2),CI(2,2),reps);
betaCI(:,3)=linspace(NAbBetaCI(1),NAbBetaCI(2),reps);
pBoot=nan(length(modelDoseRange),reps);
for k=1:100
    ciBin=[0,0,0];
    while any(ciBin<1 | ciBin>reps)
        ciBin=round(reps/2+reps/4*randn(1,3));
    end
    tmpBeta(1)=betaCI(ciBin(1),1);
    tmpBeta(2)=betaCI(ciBin(2),2);
    tmpBeta(3)=betaCI(ciBin(2),2);
    pBoot(:,k)=doseResponseModel(modelDoseRange,NAb,1,tmpBeta);
end
yCI=quantile(pBoot',[0.025,0.975])';
plotWithCI(modelDoseRange,doseResponseModel(modelDoseRange,NAb,1,[beta(1),beta(2),NAbBeta]),yCI,cmap2(2,:))


% NAb=128
NAb=2^7;
reps=100;
betaCI(:,1)=linspace(CI(1,1),CI(2,1),reps);
betaCI(:,2)=linspace(CI(1,2),CI(2,2),reps);
betaCI(:,3)=linspace(NAbBetaCI(1),NAbBetaCI(2),reps);
pBoot=nan(length(modelDoseRange),reps);
for k=1:100
    ciBin=[0,0,0];
    while any(ciBin<1 | ciBin>reps)
        ciBin=round(reps/2+reps/4*randn(1,3));
    end
    tmpBeta(1)=betaCI(ciBin(1),1);
    tmpBeta(2)=betaCI(ciBin(2),2);
    tmpBeta(3)=betaCI(ciBin(2),2);
    pBoot(:,k)=doseResponseModel(modelDoseRange,NAb,1,tmpBeta);
end
yCI=quantile(pBoot',[0.025,0.975])';
plotWithCI(modelDoseRange,doseResponseModel(modelDoseRange,NAb,1,[beta(1),beta(2),NAbBeta]),yCI,cmap2(3,:))


% NAb=2048
NAb=2^11;
reps=100;
betaCI(:,1)=linspace(CI(1,1),CI(2,1),reps);
betaCI(:,2)=linspace(CI(1,2),CI(2,2),reps);
betaCI(:,3)=linspace(NAbBetaCI(1),NAbBetaCI(2),reps);
pBoot=nan(length(modelDoseRange),reps);
for k=1:100
    ciBin=[0,0,0];
    while any(ciBin<1 | ciBin>reps)
        ciBin=round(reps/2+reps/4*randn(1,3));
    end
    tmpBeta(1)=betaCI(ciBin(1),1);
    tmpBeta(2)=betaCI(ciBin(2),2);
    tmpBeta(3)=betaCI(ciBin(2),2);
    pBoot(:,k)=doseResponseModel(modelDoseRange,NAb,1,tmpBeta);
end
yCI=quantile(pBoot',[0.025,0.975])';
plotWithCI(modelDoseRange,doseResponseModel(modelDoseRange,NAb,1,[beta(1),beta(2),NAbBeta]),yCI,cmap2(4,:))

set(gca,'xscale','log')
xlim([modelDoseRange(1),modelDoseRange(end)])
set(gca,'xtick',10.^[-3:2:6])
xlabel('dose [TCID50]')
ylabel('fraction shedding')
text(1,0.8,'N_{Ab}=1','color',cmap2(1,:));
text(1,0.7,'N_{Ab}=8','color',cmap2(2,:));
text(1,0.6,'N_{Ab}=128','color',cmap2(3,:));
text(1,0.5,'N_{Ab}=2048','color',cmap2(4,:));

subplot(3,3,7)
colormap(cmap);


%% fit IPV boosting

custnloglf = @(b,Y,cens,N) -sum(Y.*log(doseResponseModel(10^5.7,2^b)) + (N-Y).*log(1-doseResponseModel(10^5.7,2^b)));
[betaIPV,CIIPV] = mle(data.Jafari2014.IPVboost.pos','nloglf',custnloglf,'frequency',data.Jafari2014.IPVboost.N','start',[7]);
round(2^betaIPV)
round(2.^CIIPV)


custnloglf = @(b,Y,cens,N) -sum(Y.*log(doseResponseModel(10^5.7,2^b)) + (N-Y).*log(1-doseResponseModel(10^5.7,2^b)));
[betatOPVxN,CItOPVxN] = mle(data.Jafari2014.tOPVxN.pos','nloglf',custnloglf,'frequency',data.Jafari2014.tOPVxN.N','start',[7]);
round(2^betatOPVxN)
round(2.^CItOPVxN)
