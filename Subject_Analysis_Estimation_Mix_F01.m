function user = Subject_Analysis_Estimation_Mix_F01(number, sessionin, expType)

if nargin < 2
    number                  =   input('Participant Number: ','s');
    sessionin               =   input('Session Number: ');
    expType                 =   'Estimation';
end


% Load Config and anonymTools and fittingTools files
config
anonymTools
fittingTools

% Set Input Strings | Saved by Experimet
subjectStepSavingSting              =	[savingSting,'_Step_number_',num2str(number),'_sessionin_',num2str(sessionin),'.mat'];
subjectFinalSavingSting             =   [savingSting,'_Final_number_',num2str(number),'_sessionin_',num2str(sessionin),'.mat'];
subjectAllDataSavingSting           =   [savingSting,'_AllData_number_',num2str(number),'_sessionin_',num2str(sessionin),'.mat'];
subjectExceptionDataSavingSting     =   [savingSting,'_ExceptionData_number_',num2str(number),'_sessionin_',num2str(sessionin),'.mat'];

subjectInputDataMainSavingSting     =	[inputDataMainSavingSting,'_number_',num2str(number),'_sessionin_',num2str(sessionin),'.mat'];
subParametersavingStringLocal       =	[subParametersavingString,'_number_',num2str(number),'_sessionin_',num2str(sessionin),'.mat'];



stepwiseFlag                =   0;
%% -------------------------------------------------
%  -----------------Load Input Data-----------------
%  -------------------------------------------------

% Check the FINAL Dataset first!
if exist(subjectFinalSavingSting)
    load(subjectFinalSavingSting);
    % Check STEPWISE dataset if there is no FINAL dataset
elseif exist(subjectStepSavingSting)
    disp('There is no FINAL experiment data stored for this user!');
    disp('Switch to STEPWISE data!');
    load(subjectStepSavingSting);
    stepwiseFlag            =   1;
    % If there is no FINAL or STEPWISE datasets, Stop!
else
    disp('There is no Data Stored for this user!');
    disp('Maybe there was an exception! Check with Admin!');
    return;
end

%% -------------------------------------------------
%  -----------------Preliminary Calculation---------
%  -------------------------------------------------

% Calculate Total Valid Snapshots
totalValidSnapshot          =   sum([snapShots.response] ~= 0);
TotalValidOutputTrials      =   sum([trialOutputs.response] ~= 0);
totalInputTrials            =   size(inputTrials,2);

validSnapshot               =   snapShots([snapShots.response] ~= 0);
validOutput                 =   trialOutputs([trialOutputs.response] ~= 0);


validDataset                =   validSnapshot;

% If we are using FINAL dataset
if ~stepwiseFlag
    % If TOTAL VALID SNAPSHOTS are same as input trial! -> Use them
    if totalValidSnapshot == totalInputTrials
        disp('We have all the data in snapshot!');
        disp('We are Using Valid Snapshot!');
        validDataset                =   validSnapshot;
    else
        disp('There is something Wrong with the snapshot stored data!');
        disp('Number of valid snapshots are not equal with the number of input trials!');
        disp('Lets check output trial!');
        if TotalValidOutputTrials == totalInputTrials
            disp('We have all the data in output!');
            disp('We are Using Valid Output Trials!');
            validDataset                =   validOutput;
        else
            disp('There is something Wrong with the output stored data!');
            disp('Number of valid output trials are not equal with the number of input trials!');
            disp('We will compare Snapshot and Output and use the one which has bigest number of data!');
            if totalValidSnapshot > TotalValidOutputTrials
                disp('Snapshot has more data than Output!');
                disp('We have to use Snapshot data!');
                validDataset                =   validSnapshot;
            else
                disp('Output has more data than Snapshot!');
                disp('We have to use Output data!');
                validDataset                =   validOutput;
            end
        end
    end
else
    disp('We will compare Snapshot and Output and use the one which has bigest number of data!');
    if totalValidSnapshot > TotalValidOutputTrials
        disp('Snapshot has more data than Output!');
        disp('We have to use Snapshot data!');
        validDataset                =   validSnapshot;
    else
        disp('Output has more data than Snapshot!');
        disp('We have to use Output data!');
        validDataset                =   validOutput;
    end
end

% Load Subjective Parameters
load(subParametersavingStringLocal,'gamma','rho_g');

%% -------------------------------------------------
%  -----------------Reformating Valid Dataset-------
%  -------------------------------------------------
totalValidData                      =   size(validDataset,2);

% Extracting All Valid Data

% Left and Right Probabilities
formattedData.LProb                 =   parenn(cell2mat({validDataset.L_prob}'),1:totalValidData,1:3);
formattedData.RProb                 =   parenn(cell2mat({validDataset.R_prob}'),1:totalValidData,1:3);

% Left and Right Magnitudes
formattedData.LMag                  =   parenn(cell2mat({validDataset.L_mag}'),1:totalValidData,1:3);
formattedData.RMag                  =   parenn(cell2mat({validDataset.R_mag}'),1:totalValidData,1:3);

% Left and Right Expected Values
formattedData.LEV                   =   parenn(cell2mat({validDataset.L_EV}'),1:totalValidData,1);
formattedData.REV                   =   parenn(cell2mat({validDataset.R_EV}'),1:totalValidData,1);

% Differntial Expected Value
formattedData.DEV                   =   formattedData.REV - formattedData.LEV;

% Response and Response time ( 1: left; 2:right )
formattedData.Response              =   parenn(cell2mat({validDataset.response}'),1:totalValidData,1);
formattedData.ResponseTime          =   parenn(cell2mat({validDataset.responseTime}'),1:totalValidData,1);

% Left and Right Subjective Probabilities
formattedData.LSProb            =   probWeightFunc1(formattedData.LProb,gamma);
formattedData.RSProb            =   probWeightFunc1(formattedData.RProb,gamma);

% Left and Right Subjective Magnitudes
formattedData.LSMag             =   magUtilityFunc1(formattedData.LMag,rho_g);
formattedData.RSMag             =   magUtilityFunc1(formattedData.RMag,rho_g);

% Left and Right Subjective Expected Values
formattedData.LSEV              =   sum(formattedData.LSProb .* formattedData.LSMag,2);
formattedData.RSEV              =   sum(formattedData.RSProb .* formattedData.RSMag,2);

% Differntial Subjective Expected Value
formattedData.DSEV              =   formattedData.RSEV - formattedData.LSEV;

% Left and Right Subjective Expected Value (2nd version)
formattedData.LSEV2             =   sum(formattedData.LProb .* formattedData.LSMag,2);
formattedData.RSEV2             =   sum(formattedData.RProb .* formattedData.RSMag,2);

% Differntial Subjective Expected Value (2nd version)
formattedData.DSEV2             =   formattedData.RSEV2 - formattedData.LSEV2;

% Left and Right Subjective Expected Values (For each piece)
formattedData.LEVP              =   formattedData.LProb .* formattedData.LMag;
formattedData.REVP              =   formattedData.RProb .* formattedData.RMag;


end