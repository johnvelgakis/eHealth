 function varargout = ECG_f(varargin)
% ECG_F MATLAB code for ECG_f.fig
%      ECG_F, by itself, creates a new ECG_F or raises the existing
%      singleton*.
%
%      H = ECG_F returns the handle to a new ECG_F or the handle to
%      the existing singleton*.
%
%      ECG_F('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECG_F.M with the given input arguments.
%
%      ECG_F('Property','Value',...) creates a new ECG_F or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ECG_f_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ECG_f_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECG_f

% Last Modified by GUIDE v2.5 01-May-2018 17:15:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECG_f_OpeningFcn, ...
                   'gui_OutputFcn',  @ECG_f_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ECG_f is made visible.
function ECG_f_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ECG_f (see VARARGIN)

% Choose default command line output for ECG_f

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ECG_f wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ECG_f_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function BPMtag_Callback(hObject, eventdata, handles)
% hObject    handle to BPMtag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BPMtag as text
%        str2double(get(hObject,'String')) returns contents of BPMtag as a double


% --- Executes during object creation, after setting all properties.
function BPMtag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BPMtag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ECGStart.
function ECGStart_Callback(hObject, eventdata, handles)
% hObject    handle to ECGStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
clear all
data=[];
s=serial('/dev/cu.usbmodem1411');
set(s,'BaudRate',9600);       %max baud rate for matlab
fopen(s);
for i=1:1000                  %5s=1000
    x=str2num(fgetl(s));
    data=[data,x];
end
fclose(s);
l=length(data);
if mod(l,2) == 1              %need to determine the parity of the collected data in order to 
    l=l-1;                    %distinguish the airflow and the ECG data. Odd data: ECG or EMG
end                           %Even data: Airflow.
l=0.5*l;                      %Divide by 2 because the data stream contains 2 data types so for
ECGn=0;                       %the time that will be used for the plot we have to divide it by 2.
for i=1:l
    ECGn(i)=data(2*i-1)*5/1023.0;    %Arduino measurement [1,1023] so we divide by 1023 which are the
end                                  %Arduino quantization units and also the range of the sensor is 0-5V
t=(1:l)/100;

fs=200;
delay = 0;
%% ============ Noise cancelation(Filtering)( 5-15 Hz) =============== %%
% ------------------ remove the mean of Signal -----------------------%
ECGn = ECGn - mean(ECGn);
%% ==== Low Pass Filter  H(z) = ((1 - z^(-6))^2)/(1 - z^(-1))^2 ==== %%
Wn = 12*2/fs;
N = 3;                                                                  % order of 3 less processing
[a,b] = butter(N,Wn,'low');                                             % bandpass filtering
ECGlp = filtfilt(a,b,ECGn); 
ECGlp = ECGlp/ max(abs(ECGlp));
 %% ======================= start figure ============================= %
figure;
ax(1) = subplot(321);plot(ECGn);axis tight;title('Raw signal');
ax(2)=subplot(322);plot(ECGlp);axis tight;title('Low pass filtered');
grid on;
%% ==== High Pass filter H(z) = (-1+32z^(-16)+z^(-32))/(1+z^(-1)) ==== %%

Wn = 5*2/fs;
N = 3;                                                                  % order of 3 less processing
[a,b] = butter(N,Wn,'high');                                            % bandpass filtering
ECGhp = filtfilt(a,b,ECGlp); 
ECGhp = ECGhp/ max(abs(ECGhp));
ax(3)=subplot(323);plot(ECGhp);axis tight;title('High Pass Filtered');
grid on;
%%  bandpass filter for Noise cancelation of other sampling frequencies(Filtering)
f1=5;                                                                      % cuttoff low frequency to get rid of baseline wander
f2=15;                                                                     % cuttoff frequency to discard high frequency noise
Wn=[f1 f2]*2/fs;                                                           % cutt off based on fs
N = 3;                                                                     % order of 3 less processing
[a,b] = butter(N,Wn);                                                      % bandpass filtering
ECGhp = filtfilt(a,b,ECGn);
ECGhp = ECGhp/ max( abs(ECGhp));
ax(1) = subplot(3,2,[1 2]);plot(ECGn);axis tight;title('Raw Signal');
ax(3)=subplot(323);plot(ECGhp);axis tight;title('Band Pass Filtered');
grid on;
%% ==================== derivative filter ========================== %%
% ------ H(z) = (1/8T)(-z^(-2) - 2z^(-1) + 2z + z^(2)) --------- %
b = [1 2 0 -2 -1].*(1/8)*fs;   
ECGde = filtfilt(b,1,ECGhp);
ECGde = ECGde/max(ECGde);
ax(4)=subplot(324);plot(ECGde);
axis tight;
title('Filtered with the derivative filter');
grid on;
%% ========== Squaring nonlinearly enhance the dominant peaks ========== %%
ECGsq = ECGde.^2;
ax(5)=subplot(325);
plot(ECGsq);
axis tight;
title('Squared');
grid on;

%% ============  Moving average ================== %%
%-------Y(nt) = (1/N)[x(nT-(N - 1)T)+ x(nT - (N - 2)T)+...+x(nT)]---------%
ECGc = conv(ECGsq ,ones(1 ,round(0.150*fs))/round(0.150*fs));
delay = delay + round(0.150*fs)/2;
ax(6)=subplot(326);plot(ECGc);
axis tight;
title('MWI');
axis tight;
hb=0;
peak_hb=[];
peak_hb(hb)=0;
for i=1:length(EMGde)
    if EMGde(i)>EMGde(i-1) && EMGde(i)>EMGde(i+1) && EMGde(i)>0.7
        hb=hb+1;
        peak_hb(hb)=i;
    end
end

invECGc=-ECGc;
Q=0;
S=0;
peak_Q=[];
peak_S=[];
peak_Q(Q)=0;
peak_S(S)=0;
for i=1:length(invECGc)
    if ECGc(i)<ECGc(i+1) && ECGc(i)<ECGc(i-1) && ECGc(i)<0.03
        peak_Q(Q)=i;
        Q=Q+1;
    elseif ECGc(i)>ECGc(i+1) && ECGc(i)>ECGc(i-1) && ECGc(i)>0.2
        peak_S(S)=i;
        S=S+1;
    end
end
xq=length(peak_Q(Q));
xs=length(peak_S(S));
x=0;
if xq>xs
    x=xs;
else
    x=xq;
end
QRS_sum=[];
for i=1:x
    QRS_sum(i)=peak_S(i)-peak_Q(i);
end
QRS=mean(QRS_sum);
hold on
figure
ax(1) = subplot(321);plot(ECGn);axis tight;title('Raw signal, BPM: ', [num2str(hb),' beats/min, QRS:'], [num2str(QRS), ' ms'], 'FontSize' ,25 );
   %set(handles.bpmout, 'String', [num2str(hb) ' beats/min'], 'FontSize' ,25 );

% %Low Pass Butterworth IIR Filter
% b=[1 0 0 0 0 0 -2 0 0 0 0 0 1];
% a=[32 -64 32 0 0 0 0 0 0 0 0 0 0];
% ECGLP=filter(b,a,ECGn);                                            %Coefficient Bandpass Filter
% %High Pass Butterworth IIR Filter                                  %For noise reduction
% b=[-1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 32 -32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
% a=[32 -32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% ECGHP=filter(b,a,ECGLP);
% %Derivative Filter
% b=[2 1 0 -1 -2];                        
% a=[8 0 0 0 0];                  
% ECGDE=filter(b,a,ECGHP);
% %Signal Squaring
% ECGSQ=ECGDE.^2;                         %To get positive result
% h=ones(1,20)/20;
% N=length(ECGn);
% s=conv(SQ,h);                           % sliding - window integration 
% heart_beat=1;                           %To get waveform feature information
% peak=[];
% peak(heart_beat)=0;


% --- Executes on button press in ECGBack.
function ECGBack_Callback(hObject, eventdata, handles)
% hObject    handle to ECGBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Health_monitor
close(ECG_f)

% --- Executes on button press in ECGResults.
function ECGResults_Callback(hObject, eventdata, handles)
% hObject    handle to ECGResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
