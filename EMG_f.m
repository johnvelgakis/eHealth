function varargout = EMG_f(varargin)
% EMG_F MATLAB code for EMG_f.fig
%      EMG_F, by itself, creates a new EMG_F or raises the existing
%      singleton*.
%
%      H = EMG_F returns the handle to a new EMG_F or the handle to
%      the existing singleton*.
%
%      EMG_F('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMG_F.M with the given input arguments.
%
%      EMG_F('Property','Value',...) creates a new EMG_F or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EMG_f_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EMG_f_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EMG_f

% Last Modified by GUIDE v2.5 02-May-2018 00:24:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EMG_f_OpeningFcn, ...
                   'gui_OutputFcn',  @EMG_f_OutputFcn, ...
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


% --- Executes just before EMG_f is made visible.
function EMG_f_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EMG_f (see VARARGIN)

% Choose default command line output for EMG_f
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EMG_f wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EMG_f_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in resultsEMG.
function resultsEMG_Callback(hObject, eventdata, handles)
% hObject    handle to resultsEMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in start_emg.
function start_emg_Callback(hObject, eventdata, handles)
% hObject    handle to start_emg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
EMGn=0;                       %the time that will be used for the plot we have to divide it by 2.
for i=1:l
    EMGn(i)=data(2*i-1)*5/1023.0;    %Arduino measurement [1,1023] so we divide by 1023 which are the
end                                  %Arduino quantization units and also the range of the sensor is 0-5V
t=(1:l)/100;
figure
subplot(2,1,1); title('Respiration');
scatter(t,EMGn); 

filt1 = fdesign.highpass('n,f3db',4,2*10*(1/1000)); %high-pass filter, cut off frequency at 10Hz, sampling frequency of 1000Hz
H1 = design(filt1,'butter');
highpass_EMG = filter(H1, EMGn); % sampling frequency of 1000Hz
% Low-pass filter
filt2 = fdesign.lowpass('n,f3db',4,2*500*(1/1000)); %low-pass filter, cut off frequency at 500Hz
H2 = design(filt2,'butter');
lowpass_EMG = filter(H2,highpass_EMG);
% Notch Filter (50Hz)
filt3 = fdesign.notch(4,0.05,10); %notch filter (50Hz)
H3 = design(filt3);
cleaned_EMG = filter(H3,lowpass_EMG);
subplot(2,1,2); title('Respiration');
scatter(t,cleaned_EMG);       % add second plot in 2 x 1 grid
% plot using + markers



% --- Executes on button press in back_emg.
function back_emg_Callback(hObject, eventdata, handles)
% hObject    handle to back_emg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Health_monitor
close(EMG_f)
