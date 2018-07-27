%% CLEAR SKY
FILE = 'Clear_'; EXT = '.mat';
N = 10; 
PSI_Stokes = zeros(N,18);
PSI_Sahabot = zeros(N,18);
PSI_MatrixAOP = zeros(N,18);
PSI_ExtendedAOP = zeros(N,18);
PSI_AntBot = zeros(N,18);
Error_Stokes = zeros(N,18);
Error_Sahabot = zeros(N,18);
Error_MatrixAOP = zeros(N,18);
Error_ExtendedAOP = zeros(N,18);
Error_AntBot = zeros(N,18);
ANGLE = 0:10:170;
CORRECTION = (2.5/18):(2.5/18):2.5;
for i = 1:N
    UV = load(strcat(FILE,num2str(i),EXT));
    UV = UV.DATA;
    for j = 1:18
        PSI_Stokes(i,j) = Stokes(UV,j);
        PSI_Sahabot(i,j) = Sahabot(UV,j);
        PSI_MatrixAOP(i,j) = Matrix(UV,j);
        PSI_ExtendedAOP(i,j) = Extended(UV,j);
        PSI_AntBot(i,j) = AntBot(UV,j);
    end
    PSI_Stokes(i,:) = PSI_Stokes(i,:) - CORRECTION;
    PSI_Sahabot(i,:) = PSI_Sahabot(i,:) - CORRECTION;
    PSI_MatrixAOP(i,:) = PSI_MatrixAOP(i,:) - CORRECTION;
    PSI_ExtendedAOP(i,:) = PSI_ExtendedAOP(i,:) - CORRECTION;
    PSI_AntBot(i,:) = PSI_AntBot(i,:) - CORRECTION;
    PSI_Stokes(i,:) = CorrectPsi(PSI_Stokes(i,:));
    PSI_Sahabot(i,:) = CorrectPsi(PSI_Sahabot(i,:));
    PSI_MatrixAOP(i,:) = CorrectPsi(PSI_MatrixAOP(i,:));
    PSI_ExtendedAOP(i,:) = CorrectPsi(PSI_ExtendedAOP(i,:));
    PSI_AntBot(i,:) = CorrectPsi(PSI_AntBot(i,:));
    Error_Stokes(i,:) = PSI_Stokes(i,:) - ANGLE(1,:);
    Error_Sahabot(i,:) = PSI_Sahabot(i,:) - ANGLE(1,:);
    Error_MatrixAOP(i,:) = PSI_MatrixAOP(i,:) - ANGLE(1,:);
    Error_ExtendedAOP(i,:) = PSI_ExtendedAOP(i,:) - ANGLE(1,:);
    Error_AntBot(i,:) = PSI_AntBot(i,:) - ANGLE(1,:);
end

%% Saving
DATA.STOKES.PSI = PSI_Stokes;
DATA.STOKES.ERROR = Error_Stokes;
DATA.SAHABOT.PSI = PSI_Sahabot;
DATA.SAHABOT.ERROR = Error_Sahabot;
DATA.MatrixAOP.PSI = PSI_MatrixAOP;
DATA.MatrixAOP.ERROR = Error_MatrixAOP;
DATA.ExtendedAOP.PSI = PSI_ExtendedAOP;
DATA.ExtendedAOP.ERROR = Error_ExtendedAOP;
DATA.AntBot.PSI = PSI_AntBot;
DATA.AntBot.ERROR = Error_AntBot;

%% Final results

meanStokesClearSky = mean(MEAN_Stokes);
sdStokesClearSky = std(MEAN_Stokes);
meanSahabotClearSky = mean(MEAN_Sahabot);
sdSahabotClearSky = std(MEAN_Sahabot);
meanMatrixClearSky = mean(MEAN_MatrixAOP);
sdMatrixClearSky = std(MEAN_MatrixAOP);
meanExtendedClearSky = mean(MEAN_ExtendedAOP);
sdExtendedClearSky = std(MEAN_ExtendedAOP);
meanAntbotClearSky = mean(MEAN_AntBot);
sdAntbotClearSky = std(MEAN_AntBot);

pValStokesClearSky = lillietest(MEAN_Stokes);
pValSahabotClearSky = lillietest(MEAN_Sahabot);
pValMatrixClearSky = lillietest(MEAN_MatrixAOP);
pValExtendedClearSky = lillietest(MEAN_ExtendedAOP);
pValAntbotClearSky = lillietest(MEAN_AntBot);

%% Figure
figure()
    subplot(231)
        hold on;
        plot(ANGLE,PSI_Stokes','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_Stokes),'blue','linewidth',1);
        hold off;
        title('Stokes');
        axis([0 180 0 180]);
        box on;
    subplot(232)
        hold on;
        plot(ANGLE,PSI_Sahabot','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_Sahabot),'blue','linewidth',1);
        hold off;
        title('Sahabot');
        axis([0 180 0 180]);
        box on;
    subplot(233)
        hold on;
        plot(ANGLE,PSI_MatrixAOP','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_MatrixAOP),'blue','linewidth',1);
        hold off;
        title('Matrix AOP (Sahabot)');
        axis([0 180 0 180]);
        box on;
    subplot(234)
        hold on;
        plot(ANGLE,PSI_ExtendedAOP','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_ExtendedAOP),'blue','linewidth',1);
        hold off;
        title('Extended AOP');
        axis([0 180 0 180]);
        box on;
    subplot(235)
        hold on;
        plot(ANGLE,PSI_AntBot','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_AntBot),'blue','linewidth',1);
        hold off;
        title('AntBot');
        axis([0 180 0 180]);
        box on;

%% CHANGEABLE SKY
FILE = 'Changeable_'; EXT = '.mat';
N = 10; 
PSI_Stokes = zeros(N,18);
PSI_Sahabot = zeros(N,18);
PSI_MatrixAOP = zeros(N,18);
PSI_ExtendedAOP = zeros(N,18);
PSI_AntBot = zeros(N,18);
Error_Stokes = zeros(N,18);
Error_Sahabot = zeros(N,18);
Error_MatrixAOP = zeros(N,18);
Error_ExtendedAOP = zeros(N,18);
Error_AntBot = zeros(N,18);
ANGLE = 0:10:170;
for i = 1:N
    UV = load(strcat(FILE,num2str(i),EXT));
    UV = UV.DATA;
    for j = 1:18
        PSI_Stokes(i,j) = Stokes(UV,j);
        PSI_Sahabot(i,j) = Sahabot(UV,j);
        PSI_MatrixAOP(i,j) = Matrix(UV,j);
        PSI_ExtendedAOP(i,j) = Extended(UV,j);
        PSI_AntBot(i,j) = AntBot(UV,j);
    end
    PSI_Stokes(i,:) = PSI_Stokes(i,:) - CORRECTION;
    PSI_Sahabot(i,:) = PSI_Sahabot(i,:) - CORRECTION;
    PSI_MatrixAOP(i,:) = PSI_MatrixAOP(i,:) - CORRECTION;
    PSI_ExtendedAOP(i,:) = PSI_ExtendedAOP(i,:) - CORRECTION;
    PSI_AntBot(i,:) = PSI_AntBot(i,:) - CORRECTION;    
    PSI_Stokes(i,:) = CorrectPsi(PSI_Stokes(i,:));
    PSI_Sahabot(i,:) = CorrectPsi(PSI_Sahabot(i,:));
    PSI_MatrixAOP(i,:) = CorrectPsi(PSI_MatrixAOP(i,:));
    PSI_ExtendedAOP(i,:) = CorrectPsi(PSI_ExtendedAOP(i,:));
    PSI_AntBot(i,:) = CorrectPsi(PSI_AntBot(i,:));
    Error_Stokes(i,:) = PSI_Stokes(i,:) - ANGLE(1,:);
    Error_Sahabot(i,:) = PSI_Sahabot(i,:) - ANGLE(1,:);
    Error_MatrixAOP(i,:) = PSI_MatrixAOP(i,:) - ANGLE(1,:);
    Error_ExtendedAOP(i,:) = PSI_ExtendedAOP(i,:) - ANGLE(1,:);
    Error_AntBot(i,:) = PSI_AntBot(i,:) - ANGLE(1,:);
end

%% Final results

meanStokesChangeableSky = mean(MEAN_Stokes);
sdStokesChangeableSky = std(MEAN_Stokes);
meanSahabotChangeableSky = mean(MEAN_Sahabot);
sdSahabotChangeableSky = std(MEAN_Sahabot);
meanMatrixChangeableSky = mean(MEAN_MatrixAOP);
sdMatrixChangeableSky = std(MEAN_MatrixAOP);
meanExtendedChangeableSky = mean(MEAN_ExtendedAOP);
sdExtendedChangeableSky = std(MEAN_ExtendedAOP);
meanAntbotChangeableSky = mean(MEAN_AntBot);
sdAntbotChangeableSky = std(MEAN_AntBot);

pValStokesChangeableSky = lillietest(MEAN_Stokes);
pValSahabotChangeableSky = lillietest(MEAN_Sahabot);
pValMatrixChangeableSky = lillietest(MEAN_MatrixAOP);
pValExtendedChangeableSky = lillietest(MEAN_ExtendedAOP);
pValAntbotChangeableSky = lillietest(MEAN_AntBot);

%% Saving
DATA.STOKES.PSI = PSI_Stokes;
DATA.STOKES.ERROR = Error_Stokes;
DATA.SAHABOT.PSI = PSI_Sahabot;
DATA.SAHABOT.ERROR = Error_Sahabot;
DATA.MatrixAOP.PSI = PSI_MatrixAOP;
DATA.MatrixAOP.ERROR = Error_MatrixAOP;
DATA.ExtendedAOP.PSI = PSI_ExtendedAOP;
DATA.ExtendedAOP.ERROR = Error_ExtendedAOP;
DATA.AntBot.PSI = PSI_AntBot;
DATA.AntBot.ERROR = Error_AntBot;

%% Figure
figure()
    subplot(231)
        hold on;
        plot(ANGLE,PSI_Stokes','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_Stokes),'blue','linewidth',1);
        hold off;
        title('Stokes');
        axis([0 180 0 180]);
        box on;
    subplot(232)
        hold on;
        plot(ANGLE,PSI_Sahabot','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_Sahabot),'blue','linewidth',1);
        hold off;
        title('Sahabot');
        axis([0 180 0 180]);
        box on;
    subplot(233)
        hold on;
        plot(ANGLE,PSI_MatrixAOP','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_MatrixAOP),'blue','linewidth',1);
        hold off;
        title('Matrix AOP (Sahabot)');
        axis([0 180 0 180]);
        box on;
    subplot(234)
        hold on;
        plot(ANGLE,PSI_ExtendedAOP','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_ExtendedAOP),'blue','linewidth',1);
        hold off;
        title('Extended AOP');
        axis([0 180 0 180]);
        box on;
    subplot(235)
        hold on;
        plot(ANGLE,PSI_AntBot','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_AntBot),'blue','linewidth',1);
        hold off;
        title('AntBot');
        axis([0 180 0 180]);
        box on;
        
%% COVERED SKY
FILE = 'Covered_'; EXT = '.mat';
N = 6; 
PSI_Stokes = zeros(N,18);
PSI_Sahabot = zeros(N,18);
PSI_MatrixAOP = zeros(N,18);
PSI_ExtendedAOP = zeros(N,18);
PSI_AntBot = zeros(N,18);
Error_Stokes = zeros(N,18);
Error_Sahabot = zeros(N,18);
Error_MatrixAOP = zeros(N,18);
Error_ExtendedAOP = zeros(N,18);
Error_AntBot = zeros(N,18);
ANGLE = 0:10:170;
for i = 1:N
    UV = load(strcat(FILE,num2str(i),EXT));
    UV = UV.DATA;
    for j = 1:18
        PSI_Stokes(i,j) = Stokes(UV,j);
        PSI_Sahabot(i,j) = Sahabot(UV,j);
        PSI_MatrixAOP(i,j) = Matrix(UV,j);
        PSI_ExtendedAOP(i,j) = Extended(UV,j);
        PSI_AntBot(i,j) = AntBot(UV,j);
    end
    PSI_Stokes(i,:) = PSI_Stokes(i,:) - CORRECTION;
    PSI_Sahabot(i,:) = PSI_Sahabot(i,:) - CORRECTION;
    PSI_MatrixAOP(i,:) = PSI_MatrixAOP(i,:) - CORRECTION;
    PSI_ExtendedAOP(i,:) = PSI_ExtendedAOP(i,:) - CORRECTION;
    PSI_AntBot(i,:) = PSI_AntBot(i,:) - CORRECTION;    
    PSI_Stokes(i,:) = CorrectPsi(PSI_Stokes(i,:));
    PSI_Sahabot(i,:) = CorrectPsi(PSI_Sahabot(i,:));
    PSI_MatrixAOP(i,:) = CorrectPsi(PSI_MatrixAOP(i,:));
    PSI_ExtendedAOP(i,:) = CorrectPsi(PSI_ExtendedAOP(i,:));
    PSI_AntBot(i,:) = CorrectPsi(PSI_AntBot(i,:));
    Error_Stokes(i,:) = PSI_Stokes(i,:) - ANGLE(1,:);
    Error_Sahabot(i,:) = PSI_Sahabot(i,:) - ANGLE(1,:);
    Error_MatrixAOP(i,:) = PSI_MatrixAOP(i,:) - ANGLE(1,:);
    Error_ExtendedAOP(i,:) = PSI_ExtendedAOP(i,:) - ANGLE(1,:);
    Error_AntBot(i,:) = PSI_AntBot(i,:) - ANGLE(1,:);
end

%% Final results

meanStokesCoveredSky = mean(MEAN_Stokes);
sdStokesCoveredSky = std(MEAN_Stokes);
meanSahabotCoveredSky = mean(MEAN_Sahabot);
sdSahabotCoveredSky = std(MEAN_Sahabot);
meanMatrixCoveredSky = mean(MEAN_MatrixAOP);
sdMatrixCoveredSky = std(MEAN_MatrixAOP);
meanExtendedCoveredSky = mean(MEAN_ExtendedAOP);
sdExtendedCoveredSky = std(MEAN_ExtendedAOP);
meanAntbotCoveredSky = mean(MEAN_AntBot);
sdAntbotCoveredSky = std(MEAN_AntBot);

pValStokesCoveredSky = lillietest(MEAN_Stokes);
pValSahabotCoveredSky = lillietest(MEAN_Sahabot);
pValMatrixCoveredSky = lillietest(MEAN_MatrixAOP);
pValExtendedCoveredSky = lillietest(MEAN_ExtendedAOP);
pValAntbotCoveredSky = lillietest(MEAN_AntBot);

%% Saving
DATA.STOKES.PSI = PSI_Stokes;
DATA.STOKES.ERROR = Error_Stokes;
DATA.SAHABOT.PSI = PSI_Sahabot;
DATA.SAHABOT.ERROR = Error_Sahabot;
DATA.MatrixAOP.PSI = PSI_MatrixAOP;
DATA.MatrixAOP.ERROR = Error_MatrixAOP;
DATA.ExtendedAOP.PSI = PSI_ExtendedAOP;
DATA.ExtendedAOP.ERROR = Error_ExtendedAOP;
DATA.AntBot.PSI = PSI_AntBot;
DATA.AntBot.ERROR = Error_AntBot;

%% Figure
figure()
    subplot(231)
        hold on;
        plot(ANGLE,PSI_Stokes','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_Stokes),'blue','linewidth',1);
        hold off;
        title('Stokes');
        axis([0 180 0 180]);
        box on;
    subplot(232)
        hold on;
        plot(ANGLE,PSI_Sahabot','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_Sahabot),'blue','linewidth',1);
        hold off;
        title('Sahabot');
        axis([0 180 0 180]);
        box on;
    subplot(233)
        hold on;
        plot(ANGLE,PSI_MatrixAOP','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_MatrixAOP),'blue','linewidth',1);
        hold off;
        title('Matrix AOP (Sahabot)');
        axis([0 180 0 180]);
        box on;
    subplot(234)
        hold on;
        plot(ANGLE,PSI_ExtendedAOP','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_ExtendedAOP),'blue','linewidth',1);
        hold off;
        title('Extended AOP');
        axis([0 180 0 180]);
        box on;
    subplot(235)
        hold on;
        plot(ANGLE,PSI_AntBot','black.','markersize',4);
        plot(ANGLE,ANGLE,'red','linewidth',1.5);
        plot(ANGLE,mean(PSI_AntBot),'blue','linewidth',1);
        hold off;
        title('AntBot');
        axis([0 180 0 180]);
        box on;
 
%% BoxPlots & Statistics
CLEAR = load('Data_Clear_Sky.mat');
CLEAR = CLEAR.DATA;
COVERED = load('Data_Covered_Sky.mat');
COVERED = COVERED.DATA;
CHANGEABLE = load('Data_Changeable_Sky.mat');
CHANGEABLE = CHANGEABLE.DATA;   
figure()
hold on;
boxplot([reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])',zeros(180,1),reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',zeros(180,1),reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',zeros(180,1),reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',zeros(180,1), reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])',zeros(180,1)],'whisker',1000)
boxplot([zeros(108,1),zeros(108,1),reshape(COVERED.STOKES.ERROR,1,[])',zeros(108,1),zeros(108,1),reshape(COVERED.SAHABOT.ERROR,1,[])',zeros(108,1),zeros(108,1),reshape(COVERED.MatrixAOP.ERROR,1,[])',zeros(108,1),zeros(108,1),reshape(COVERED.ExtendedAOP.ERROR,1,[])', zeros(108,1),zeros(108,1),reshape(COVERED.AntBot.ERROR,1,[])'],'whisker',1000)
hold off;
grid on;
grid minor;
set(gca,'XTick',0,'XGrid','off')    
axis([0 16 -300 60]); 
%% Statistics - Normality Tests
CLEAR = load('Data_Clear_Sky.mat');
CLEAR = CLEAR.DATA;
COVERED = load('Data_Covered_Sky.mat');
COVERED = COVERED.DATA;
CHANGEABLE = load('Data_Changeable_Sky.mat');
CHANGEABLE = CHANGEABLE.DATA;   
% Lilliefors Normality Test
[~,p1_1] = lillietest(reshape(CLEAR.STOKES.ERROR,1,[])');
[~,p1_2] = lillietest(reshape(CLEAR.SAHABOT.ERROR,1,[])');
[~,p1_3] = lillietest(reshape(CLEAR.MatrixAOP.ERROR,1,[])');
[~,p1_4] = lillietest(reshape(CLEAR.ExtendedAOP.ERROR,1,[])');
[~,p1_5] = lillietest(reshape(CLEAR.AntBot.ERROR,1,[])');

[~,p2_1] = lillietest(reshape(CHANGEABLE.STOKES.ERROR,1,[])');
[~,p2_2] = lillietest(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])');
[~,p2_3] = lillietest(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])');
[~,p2_4] = lillietest(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])');
[~,p2_5] = lillietest(reshape(CHANGEABLE.AntBot.ERROR,1,[])');

[~,p3_1] = lillietest(reshape(COVERED.STOKES.ERROR,1,[])');
[~,p3_2] = lillietest(reshape(COVERED.SAHABOT.ERROR,1,[])');
[~,p3_3] = lillietest(reshape(COVERED.MatrixAOP.ERROR,1,[])');
[~,p3_4] = lillietest(reshape(COVERED.ExtendedAOP.ERROR,1,[])');
[~,p3_5] = lillietest(reshape(COVERED.AntBot.ERROR,1,[])');

% Shapiro Wilk Normality Test
alpha = 0.05;
[~,pSW1_1,~] = swtest(reshape(CLEAR.STOKES.ERROR,1,[])',alpha);
[~,pSW1_2,~] = swtest(reshape(CLEAR.SAHABOT.ERROR,1,[])',alpha);
[~,pSW1_3,~] = swtest(reshape(CLEAR.MatrixAOP.ERROR,1,[])',alpha);
[~,pSW1_4,~] = swtest(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',alpha);
[~,pSW1_5,~] = swtest(reshape(CLEAR.AntBot.ERROR,1,[])',alpha);

[~,pSW2_1,~] = swtest(reshape(CHANGEABLE.STOKES.ERROR,1,[])',alpha);
[~,pSW2_2,~] = swtest(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',alpha);
[~,pSW2_3,~] = swtest(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',alpha);
[~,pSW2_4,~] = swtest(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',alpha);
[~,pSW2_5,~] = swtest(reshape(CHANGEABLE.AntBot.ERROR,1,[])',alpha);

[~,pSW3_1,~] = swtest(reshape(COVERED.STOKES.ERROR,1,[])',alpha);
[~,pSW3_2,~] = swtest(reshape(COVERED.SAHABOT.ERROR,1,[])',alpha);
[~,pSW3_3,~] = swtest(reshape(COVERED.MatrixAOP.ERROR,1,[])',alpha);
[~,pSW3_4,~] = swtest(reshape(COVERED.ExtendedAOP.ERROR,1,[])',alpha);
[~,pSW3_5,~] = swtest(reshape(COVERED.AntBot.ERROR,1,[])',alpha);

%% Comparison between data-sets (Wilcoxon rank sum test)
% Default option is "both", meaning the test will state on the difference
% between x a y vectors' medians. 
CLEAR = load('Data_Clear_Sky.mat');
CLEAR = CLEAR.DATA;
COVERED = load('Data_Covered_Sky.mat');
COVERED = COVERED.DATA;
CHANGEABLE = load('Data_Changeable_Sky.mat');
CHANGEABLE = CHANGEABLE.DATA;   
% CLEAR SKY
p_W_1_11 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])');
p_W_1_12 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])');
p_W_1_13 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])');
p_W_1_14 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])');
p_W_1_15 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])');

p_W_1_21 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])');
p_W_1_22 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])');
p_W_1_23 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])');
p_W_1_24 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])');
p_W_1_25 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])');

p_W_1_31 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])');
p_W_1_32 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])');
p_W_1_33 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])');
p_W_1_34 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])');
p_W_1_35 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])');

p_W_1_41 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])');
p_W_1_42 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])');
p_W_1_43 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])');
p_W_1_44 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])');
p_W_1_45 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])');

p_W_1_51 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])');
p_W_1_52 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])');
p_W_1_53 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])');
p_W_1_54 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])');
p_W_1_55 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])');

% CHANGEABLE SKY
p_W_2_11 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])');
p_W_2_12 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])');
p_W_2_13 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])');
p_W_2_14 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])');
p_W_2_15 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])');

p_W_2_21 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])');
p_W_2_22 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])');
p_W_2_23 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])');
p_W_2_24 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])');
p_W_2_25 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])');

p_W_2_31 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])');
p_W_2_32 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])');
p_W_2_33 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])');
p_W_2_34 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])');
p_W_2_35 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])');

p_W_2_41 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])');
p_W_2_42 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])');
p_W_2_43 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])');
p_W_2_44 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])');
p_W_2_45 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])');

p_W_2_51 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])');
p_W_2_52 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])');
p_W_2_53 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])');
p_W_2_54 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])');
p_W_2_55 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])');

% COVERED SKY
p_W_3_11 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])');
p_W_3_12 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])');
p_W_3_13 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])');
p_W_3_14 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])');
p_W_3_15 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])');

p_W_3_21 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])');
p_W_3_22 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])');
p_W_3_23 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])');
p_W_3_24 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])');
p_W_3_25 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])');

p_W_3_31 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])');
p_W_3_32 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])');
p_W_3_33 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])');
p_W_3_34 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])');
p_W_3_35 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])');

p_W_3_41 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])');
p_W_3_42 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])');
p_W_3_43 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])');
p_W_3_44 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])');
p_W_3_45 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])');

p_W_3_51 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])');
p_W_3_52 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])');
p_W_3_53 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])');
p_W_3_54 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])');
p_W_3_55 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])');

T = 40;
A = ones(1,2);
Im_CLEAR = floor(T-T*[p_W_1_11.*A, p_W_1_12.*A, p_W_1_13.*A, p_W_1_14.*A, p_W_1_15.*A;
            p_W_1_21.*A, p_W_1_22.*A, p_W_1_23.*A, p_W_1_24.*A, p_W_1_25.*A;
            p_W_1_31.*A, p_W_1_32.*A, p_W_1_33.*A, p_W_1_34.*A, p_W_1_35.*A;
            p_W_1_41.*A, p_W_1_42.*A, p_W_1_43.*A, p_W_1_44.*A, p_W_1_45.*A;
            p_W_1_51.*A, p_W_1_52.*A, p_W_1_53.*A, p_W_1_54.*A, p_W_1_55.*A]);
Im_CLEAR = floor(Im_CLEAR*255/T)
Im_CLEAR = imresize(Im_CLEAR,20,'nearest');          
Im_CHANGEABLE = floor(T-T*[p_W_2_11.*A, p_W_2_12.*A, p_W_2_13.*A, p_W_2_14.*A, p_W_2_15.*A;
            p_W_2_21.*A, p_W_2_22.*A, p_W_2_23.*A, p_W_2_24.*A, p_W_2_25.*A;
            p_W_2_31.*A, p_W_2_32.*A, p_W_2_33.*A, p_W_2_34.*A, p_W_2_35.*A;
            p_W_2_41.*A, p_W_2_42.*A, p_W_2_43.*A, p_W_2_44.*A, p_W_2_45.*A;
            p_W_2_51.*A, p_W_2_52.*A, p_W_2_53.*A, p_W_2_54.*A, p_W_2_55.*A]);
Im_CHANGEABLE = floor(Im_CHANGEABLE*255/T);
Im_CHANGEABLE = imresize(Im_CHANGEABLE,20,'nearest');   
Im_COVERED = floor(T-T*[p_W_3_11.*A, p_W_3_12.*A, p_W_3_13.*A, p_W_3_14.*A, p_W_3_15.*A;
            p_W_3_21.*A, p_W_3_22.*A, p_W_3_23.*A, p_W_3_24.*A, p_W_3_25.*A;
            p_W_3_31.*A, p_W_3_32.*A, p_W_3_33.*A, p_W_3_34.*A, p_W_3_35.*A;
            p_W_3_41.*A, p_W_3_42.*A, p_W_3_43.*A, p_W_3_44.*A, p_W_3_45.*A;
            p_W_3_51.*A, p_W_3_52.*A, p_W_3_53.*A, p_W_3_54.*A, p_W_3_55.*A]);
Im_COVERED = floor(Im_COVERED*255/T);
Im_COVERED = imresize(Im_COVERED,20,'nearest');   

figure()
    subplot(311)
        imagesc(Im_CLEAR);
        set(gca,'XTickLabel',{[]});
        set(gca,'YTickLabel',{[]});
        set(gca,'XTick',[]);
        set(gca,'YTick',[]);
    subplot(312)
        imagesc(Im_CHANGEABLE);
        set(gca,'XTickLabel',{[]});
        set(gca,'YTickLabel',{[]});
        set(gca,'XTick',[]);
        set(gca,'YTick',[]);
    subplot(313)
        imagesc(Im_COVERED);
        set(gca,'XTickLabel',{[]});
        set(gca,'YTickLabel',{[]});
        set(gca,'XTick',[]);
        set(gca,'YTick',[]);
        
%% Which one is higher ? (right cond, Wilcoxon test)
CLEAR = load('Data_Clear_Sky.mat');
CLEAR = CLEAR.DATA;
COVERED = load('Data_Covered_Sky.mat');
COVERED = COVERED.DATA;
CHANGEABLE = load('Data_Changeable_Sky.mat');
CHANGEABLE = CHANGEABLE.DATA;  
% CLEAR SKY
p_W_1_11 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])','tail','right');
p_W_1_12 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])','tail','right');
p_W_1_13 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])','tail','right');
p_W_1_14 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_1_15 = ranksum(reshape(CLEAR.STOKES.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])','tail','right');

p_W_1_21 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])','tail','right');
p_W_1_22 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])','tail','right');
p_W_1_23 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])','tail','right');
p_W_1_24 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_1_25 = ranksum(reshape(CLEAR.SAHABOT.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])','tail','right');

p_W_1_31 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])','tail','right');
p_W_1_32 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])','tail','right');
p_W_1_33 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])','tail','right');
p_W_1_34 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_1_35 = ranksum(reshape(CLEAR.MatrixAOP.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])','tail','right');

p_W_1_41 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])','tail','right');
p_W_1_42 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])','tail','right');
p_W_1_43 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])','tail','right');
p_W_1_44 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_1_45 = ranksum(reshape(CLEAR.ExtendedAOP.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])','tail','right');

p_W_1_51 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.STOKES.ERROR,1,[])','tail','right');
p_W_1_52 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.SAHABOT.ERROR,1,[])','tail','right');
p_W_1_53 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.MatrixAOP.ERROR,1,[])','tail','right');
p_W_1_54 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_1_55 = ranksum(reshape(CLEAR.AntBot.ERROR,1,[])',reshape(CLEAR.AntBot.ERROR,1,[])','tail','right');

% CHANGEABLE SKY
p_W_2_11 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])','tail','right');
p_W_2_12 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])','tail','right');
p_W_2_13 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])','tail','right');
p_W_2_14 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_2_15 = ranksum(reshape(CHANGEABLE.STOKES.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])','tail','right');

p_W_2_21 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])','tail','right');
p_W_2_22 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])','tail','right');
p_W_2_23 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])','tail','right');
p_W_2_24 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_2_25 = ranksum(reshape(CHANGEABLE.SAHABOT.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])','tail','right');

p_W_2_31 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])','tail','right');
p_W_2_32 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])','tail','right');
p_W_2_33 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])','tail','right');
p_W_2_34 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_2_35 = ranksum(reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])','tail','right');

p_W_2_41 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])','tail','right');
p_W_2_42 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])','tail','right');
p_W_2_43 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])','tail','right');
p_W_2_44 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_2_45 = ranksum(reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])','tail','right');

p_W_2_51 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.STOKES.ERROR,1,[])','tail','right');
p_W_2_52 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.SAHABOT.ERROR,1,[])','tail','right');
p_W_2_53 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.MatrixAOP.ERROR,1,[])','tail','right');
p_W_2_54 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_2_55 = ranksum(reshape(CHANGEABLE.AntBot.ERROR,1,[])',reshape(CHANGEABLE.AntBot.ERROR,1,[])','tail','right');

% COVERED SKY
p_W_3_11 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])','tail','right');
p_W_3_12 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])','tail','right');
p_W_3_13 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])','tail','right');
p_W_3_14 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_3_15 = ranksum(reshape(COVERED.STOKES.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])','tail','right');

p_W_3_21 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])','tail','right');
p_W_3_22 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])','tail','right');
p_W_3_23 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])','tail','right');
p_W_3_24 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_3_25 = ranksum(reshape(COVERED.SAHABOT.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])','tail','right');

p_W_3_31 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])','tail','right');
p_W_3_32 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])','tail','right');
p_W_3_33 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])','tail','right');
p_W_3_34 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_3_35 = ranksum(reshape(COVERED.MatrixAOP.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])','tail','right');

p_W_3_41 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])','tail','right');
p_W_3_42 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])','tail','right');
p_W_3_43 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])','tail','right');
p_W_3_44 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_3_45 = ranksum(reshape(COVERED.ExtendedAOP.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])','tail','right');

p_W_3_51 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.STOKES.ERROR,1,[])','tail','right');
p_W_3_52 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.SAHABOT.ERROR,1,[])','tail','right');
p_W_3_53 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.MatrixAOP.ERROR,1,[])','tail','right');
p_W_3_54 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.ExtendedAOP.ERROR,1,[])','tail','right');
p_W_3_55 = ranksum(reshape(COVERED.AntBot.ERROR,1,[])',reshape(COVERED.AntBot.ERROR,1,[])','tail','right');