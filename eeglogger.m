function [AllOK output_matrix nS] = eeglogger(rectime,varargin)
% function [AllOK output_matrix nS] = eeglogger(rectime,acqtime,lib_flag_popup, plot_popup)
%
%
% Francesco Tenore, JHU/APL - April 2010
% 
% Copyright ? May 2010 The Johns Hopkins University Applied Physics 
% Laboratory (JHU/APL).  All Rights Reserved.
% JHU/APL PROVIDES THIS SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND 
% AND IS NOT LIABLE FOR ANY DAMAGES OF ANY KIND ARISING FROM THE USE 
% OF THIS SOFTWARE.

%
% This function uses the Emotiv Epoc headset dll (edk.dll) to acquire the 
% data contained in the EE_DataChannels_enum structure. The function mimics 
% the EEGLogger.exe function that can be compiled and used to acquire the
% data using a C++ compiler.
% Additionally, it checks to make sure that the library hasn't been loaded
% yet. The function requires no inputs (4 optional) and produces 3 outputs
%
% Optional Inputs
% rectime: this is time, in seconds, of the data buffer size, default = 1
% acqtime: acquisition time, in seconds, default = 10 (for testing).
% lib_flag_popup: 1 = activates the libfunctionsview window, useful for 
% looking at all the functions that were loaded from the dll. default = 0.
% plot_popup: 1 = plots the GyroX and GyroY signals after the data was
% recorded; 0 = no plot, default = 1.
%
% Outputs:
% AllOK: Everything worked fine in loading the library. If this is the case
% a ZERO (0) should be returned.
% output_matrix: a 25 (=length(EE_DataChannels_enum) by n matrix where n =
% sampling_frequency * acquisition time. The sampling_frequency, as defined
% by Emotiv, is effectively 128 Hz.
% nS: provides you with the number of samples acquired (equivalent to nSamplesTaken
% in the EEGLogger main.cpp function).

% data structures, copied and pasted from epocmfile.m
structs.InputSensorDescriptor_struct.members=struct('channelId', 'EE_InputChannels_enum', 'fExists', 'int32', 'pszLabel', 'cstring', 'xLoc', 'double', 'yLoc', 'double', 'zLoc', 'double');
enuminfo.EE_DataChannels_enum=struct('ED_COUNTER',0,'ED_INTERPOLATED',1,'ED_RAW_CQ',2,'ED_AF3',3,'ED_F7',4,'ED_F3',5,'ED_FC5',6,'ED_T7',7,'ED_P7',8,'ED_O1',9,'ED_O2',10,'ED_P8',11,'ED_T8',12,'ED_FC6',13,'ED_F4',14,'ED_F8',15,'ED_AF4',16,'ED_GYROX',17,'ED_GYROY',18,'ED_TIMESTAMP',19,'ED_ES_TIMESTAMP',20,'ED_FUNC_ID',21,'ED_FUNC_VALUE',22,'ED_MARKER',23,'ED_SYNC_SIGNAL',24);
enuminfo.EE_CognitivTrainingControl_enum=struct('COG_NONE',0,'COG_START',1,'COG_ACCEPT',2,'COG_REJECT',3,'COG_ERASE',4,'COG_RESET',5);
enuminfo.EE_ExpressivAlgo_enum=struct('EXP_NEUTRAL',1,'EXP_BLINK',2,'EXP_WINK_LEFT',4,'EXP_WINK_RIGHT',8,'EXP_HORIEYE',16,'EXP_EYEBROW',32,'EXP_FURROW',64,'EXP_SMILE',128,'EXP_CLENCH',256,'EXP_LAUGH',512,'EXP_SMIRK_LEFT',1024,'EXP_SMIRK_RIGHT',2048);
enuminfo.EE_ExpressivTrainingControl_enum=struct('EXP_NONE',0,'EXP_START',1,'EXP_ACCEPT',2,'EXP_REJECT',3,'EXP_ERASE',4,'EXP_RESET',5);
enuminfo.EE_ExpressivThreshold_enum=struct('EXP_SENSITIVITY',0);
enuminfo.EE_CognitivEvent_enum=struct('EE_CognitivNoEvent',0,'EE_CognitivTrainingStarted',1,'EE_CognitivTrainingSucceeded',2,'EE_CognitivTrainingFailed',3,'EE_CognitivTrainingCompleted',4,'EE_CognitivTrainingDataErased',5,'EE_CognitivTrainingRejected',6,'EE_CognitivTrainingReset',7,'EE_CognitivAutoSamplingNeutralCompleted',8,'EE_CognitivSignatureUpdated',9);
enuminfo.EE_EmotivSuite_enum=struct('EE_EXPRESSIV',0,'EE_AFFECTIV',1,'EE_COGNITIV',2);
enuminfo.EE_ExpressivEvent_enum=struct('EE_ExpressivNoEvent',0,'EE_ExpressivTrainingStarted',1,'EE_ExpressivTrainingSucceeded',2,'EE_ExpressivTrainingFailed',3,'EE_ExpressivTrainingCompleted',4,'EE_ExpressivTrainingDataErased',5,'EE_ExpressivTrainingRejected',6,'EE_ExpressivTrainingReset',7);
enuminfo.EE_CognitivAction_enum=struct('COG_NEUTRAL',1,'COG_PUSH',2,'COG_PULL',4,'COG_LIFT',8,'COG_DROP',16,'COG_LEFT',32,'COG_RIGHT',64,'COG_ROTATE_LEFT',128,'COG_ROTATE_RIGHT',256,'COG_ROTATE_CLOCKWISE',512,'COG_ROTATE_COUNTER_CLOCKWISE',1024,'COG_ROTATE_FORWARDS',2048,'COG_ROTATE_REVERSE',4096,'COG_DISAPPEAR',8192);
enuminfo.EE_InputChannels_enum=struct('EE_CHAN_CMS',0,'EE_CHAN_DRL',1,'EE_CHAN_FP1',2,'EE_CHAN_AF3',3,'EE_CHAN_F7',4,'EE_CHAN_F3',5,'EE_CHAN_FC5',6,'EE_CHAN_T7',7,'EE_CHAN_P7',8,'EE_CHAN_O1',9,'EE_CHAN_O2',10,'EE_CHAN_P8',11,'EE_CHAN_T8',12,'EE_CHAN_FC6',13,'EE_CHAN_F4',14,'EE_CHAN_F8',15,'EE_CHAN_AF4',16,'EE_CHAN_FP2',17);
enuminfo.EE_ExpressivSignature_enum=struct('EXP_SIG_UNIVERSAL',0,'EXP_SIG_TRAINED',1);
enuminfo.EE_Event_enum=struct('EE_UnknownEvent',0,'EE_EmulatorError',1,'EE_ReservedEvent',2,'EE_UserAdded',16,'EE_UserRemoved',32,'EE_EmoStateUpdated',64,'EE_ProfileEvent',128,'EE_CognitivEvent',256,'EE_ExpressivEvent',512,'EE_InternalStateChanged',1024,'EE_AllEvent',2032);

DataChannels = enuminfo.EE_DataChannels_enum;
DataChannelsNames = {'ED_COUNTER','ED_INTERPOLATED','ED_RAW_CQ','ED_AF3','ED_F7','ED_F3','ED_FC5','ED_T7','ED_P7','ED_O1','ED_O2','ED_P8','ED_T8','ED_FC6','ED_F4','ED_F8','ED_AF4','ED_GYROX','ED_GYROY','ED_TIMESTAMP','ED_ES_TIMESTAMP','ED_FUNC_ID','ED_FUNC_VALUE','ED_MARKER','ED_SYNC_SIGNAL'};



optargin = size(varargin,2);
rectime = 1;
acqtime = 10;
lib_flag_popup = 1;
plot_popup = 1;

if optargin > 4
    error('Too many inputs');
    
elseif optargin == 4
	rectime = varargin{1};
    acqtime = varargin{2};
    lib_flag_popup = varargin{3};
    plot_popup = varargin{4};
elseif optargin == 3
	rectime = varargin{1};
    acqtime = varargin{2};
    lib_flag_popup = varargin{3};
elseif optargin == 2    
	rectime = varargin{1};
    acqtime = varargin{2};
elseif optargin == 1
    rectime = varargin{1};
end
% Check to see if library was already loaded
if ~libisloaded('edk')    
    [nf, w] = loadlibrary('edk','edk');
	disp(['EDK library loaded']);
    if( lib_flag_popup )
        libfunctionsview('edk')
        nf % these should be empty if all went well
        w
    end
else
    disp(['EDK library already loaded']);
end
sampFreq = 128;
default = int8(['Emotiv Systems-5' 0]);
AllOK = calllib('edk','EE_EngineConnect',default); % success means this value is 0

hData = calllib('edk','EE_DataCreate');
calllib('edk','EE_DataSetBufferSizeInSec',rectime);
eEvent = calllib('edk','EE_EmoEngineEventCreate');
readytocollect = false;
cnt = 0;


% initialize outputs:
output_matrix = zeros(acqtime*sampFreq,length(DataChannelsNames));
nS = zeros(acqtime*sampFreq,1);

% For this next part, see the eeglogger main.cpp file for a better
% understanding of what's happening here.

tic
while(toc < acqtime)
    state = calllib('edk','EE_EngineGetNextEvent',eEvent); % state = 0 if everything's OK
    eventType = calllib('edk','EE_EmoEngineEventGetType',eEvent);
    %disp(eventType);
    userID=libpointer('uint32Ptr',0);
    calllib('edk','EE_EmoEngineEventGetUserId',eEvent, userID);


    if strcmp(eventType,'EE_UserAdded') == true
        User_added = 1;
        userID_value = get(userID,'value');
        calllib('edk','EE_DataAcquisitionEnable',userID_value,true);
    	readytocollect = true;
    end
	
	if (readytocollect) 
						
    	calllib('edk','EE_DataUpdateHandle', 0, hData);
    	nSamples = libpointer('uint32Ptr',0);
        calllib('edk','EE_DataGetNumberOfSample',hData,nSamples);
        nSamplesTaken = get(nSamples,'value') ;
        if (nSamplesTaken ~= 0)
        	data = libpointer('doublePtr',zeros(1,nSamplesTaken));
   %          for sampleIdx=1:nSamplesTaken
            	for i = 1:length(fieldnames(enuminfo.EE_DataChannels_enum))
                	calllib('edk','EE_DataGet',hData, DataChannels.([DataChannelsNames{i}]), data, uint32(nSamplesTaken));
                    data_value = get(data,'value');
%                    output_matrix(cnt+1,i) = data_value(sampleIdx);                                         
                    output_matrix(cnt+1:cnt+length(data_value),i) = data_value;                    
                end	                
                nS(cnt+1) = nSamplesTaken;
%                cnt = cnt + 1;
                cnt = cnt + length(data_value);
%             end
        end
	end
    %    pause(0.1);    % haven't played with this much...
   
end
% extract sampling rate (should be 128)
sampRateOutPtr = libpointer('uint32Ptr',0);
calllib('edk','EE_DataGetSamplingRate',0,sampRateOutPtr);
sampFreqOut = get(sampRateOutPtr,'value') % in Hz

calllib('edk','EE_DataFree',hData);
end_time = find(output_matrix(:,20)==0,1) - 1;
if plot_popup
    figure;    
    plot([0:1/sampFreq:(end_time-1)/sampFreq],output_matrix(1:end_time,18))
    hold on
    plot([0:1/sampFreq:(end_time-1)/sampFreq],output_matrix(1:end_time,19),'r')
    xlabel('time (s)')
    title('GyroX GyroZ values') % I call it gyroZ instead of gyroY ...
                                % because if I move the headset up and ...
                                % down it tracks.
    legend('GyroX','GyroZ');
    figure;
    plot3([0:1/sampFreq:(end_time-1)/sampFreq],output_matrix(1:end_time,18),output_matrix(1:end_time,19))
    xlabel('time (s)')
    ylabel('X coord')
    zlabel('Y coord')
end

% unloadlibrary('edk'); % unload the library after having turned off 
% [int32, uint32Ptr] EE_DataGetSamplingRate (uint32, uint32Ptr)
% int32 EE_DataSetSychronizationSignal (uint32, int32)
% [int32, string] EE_EnableDiagnostics (cstring, int32, int32)

