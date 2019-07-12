%% Time Config

% General
evalTimeSec                     =   10; %1.25
choiceTimeSec                   =   10; %2
isiTimeSec                      =   10; %0.5
feedbackTimeSec                 =   10; %1
drawTimeSec                     =   10;

% Learning
LearningTime.evalTimeSec        =   10; %1.25
LearningTime.choiceTimeSec      =   10; %2
LearningTime.isiTimeSec         =   10; %0.5
LearningTime.feedbackTimeSec    =   10; %1
LearningTime.drawTimeSec        =   10;

% Estimation
EstimationTime.evalTimeSec      =   10; %1.25
EstimationTime.choiceTimeSec    =   10; %2
EstimationTime.isiTimeSec       =   10; %0.5
EstimationTime.feedbackTimeSec  =   10; %1
EstimationTime.drawTimeSec      =   10;

% Main
MainTime.evalTimeSec            =   10; %1.25
MainTime.choiceTimeSec          =   10; %2
MainTime.isiTimeSec             =   10; %0.5
MainTime.feedbackTimeSec        =   10; %1
MainTime.drawTimeSec            =   10;

%% Window Mode
windowedModeConfig              =   1;

%% Define Colors
whiteColor                      =   [1 1 1];% WhiteIndex(screenNumber);
blackColor                      =   [0 0 0];% BlackIndex(screenNumber);
yellowColor                     =   [1 1 0];
blueColor                       =   [0 0 1];
redColor                        =   [1 0 0];
greenColor                      =   [0 1 0];
goldColor                       =   [255 215 0] / 255;
silverColor                     =   [192 192 192] / 255;
grayColor                       =   [128 128 128] / 255;
darkslategrayColor              =   [47 79 79] / 255;
orangeColor                     =   [0 0 0]; % EDIT

choosenColor                    =   goldColor;
unchoosenColor                  =   whiteColor;

choosenBlinkColor               =   goldColor;
unchoosenBlinkColor             =   whiteColor;

successColor                    =   goldColor;
unsuccessColor                  =   whiteColor;

cyanColor                       =   [0 1 1];
magentaColor                    =   [1 0 1];

greenComplementColor            =   [0 255 0]/255;
magentaComplementColor          =   [255 0 128]/255;
purpleComplementColor           =   [128 0 255]/255;

threeColors                     =   [greenComplementColor;magentaComplementColor;purpleComplementColor];

% randColorIdx                    =   randperm(3);
if exist(['./UserData/randColorIdx_number',num2str(number),'.mat'],'file')
    load(['./UserData/randColorIdx_number',num2str(number),'.mat'],'randColorIdx');
else
    randColorIdx                    =   [1 2 3];
end

colorMag.V0                     =   [grayColor];
colorMag.VS                     =   [threeColors(randColorIdx(1),:)];
colorMag.VM                     =   [threeColors(randColorIdx(2),:)];
colorMag.VL                     =   [threeColors(randColorIdx(3),:)];

colorMag.V0                     =   [grayColor];
colorMag.V1                     =   colorMag.VS;
colorMag.V2                     =   colorMag.VM;
colorMag.V4                     =   colorMag.VL;

%% Set the maximum rect size
maxRectX                        =   50;
maxRectY                        =   200;

leftSideRatio = 0.25;
rightSideRatio = 0.75;

% Savign Location
savingFolder                    =   './ExpDataStorage/';
InputFolder                     =   './ExpDataInput/';

savingPrefix                    =   ['ExpRes_',expType,'_'];
savingSting                     =   [savingFolder,savingPrefix];

inputDataPrefix                 =   ['InputData_',expType,'_'];
inputDataSavingSting            =   [InputFolder,inputDataPrefix];

inputDataMainPrefix             =   ['InputData_','Main','_'];
inputDataMainSavingSting        =   [InputFolder,inputDataMainPrefix];

subParametersavingPrefix        =   ['SubParam_'];
subParametersavingString        =   [savingFolder,subParametersavingPrefix];

%% Trial types
trialType.Learning              =   'Learning';
trialType.Estimation            =   'Estimation';
trialType.Mains                 =   'Main';


% Pre requaierd value onitiation
snapShots = [];

%% Default Mag and Prob s
magStorage          =   [0 1 2 4];
probStorage         =   [0.1:0.1:0.9];

magS.V0             =   0;
magS.VS             =   1;
magS.VM             =   2;
magS.VL             =   4;

%% ------------------------------------------------------------------------
%------------------------Main Experiment settings--------------------------
%--------------------------------------------------------------------------
 
% It would be maxMainTrial*40 + maxCatchTrial at the end
maxMainTrial                    =   70;
maxCatchTrial                   =   20;

binPercentage                   =   0.05;

%% ------------------------------------------------------------------------
%------------------------Other settings------------------------------------
%--------------------------------------------------------------------------

% Pen width for the frames
penWidthPixels                  =   0;
penWidthPixelsRectFixed         =   2;
penWidthPixelsRectFixedBlinker  =   7;

% Here we set the size of the arms of our fixation cross
fixCrossDimPix                  =   20;

% Set the line width for our fixation cross
lineWidthPix                    =   2;

% Mag Text Offsets for DrawColor
magTextXOffset                   =   -12;
magTextYOffset                   =   160;

% PT Text Offsets
PTTextXOffset                   =   -12;
PTTextYOffset                   =   60;

% Bar Offsets
barCoords                       =   40 * [-1 1 0 0; 0 0 0 0];
barTestXOffset                  =   0;
barTestYOffset                  =   60;

% Blink Fram Interval for Feedback Part
blinkFramInterval               =   25;

% Plot Test Flag in Estimation Analysis
plotTestFlag                    =   0;