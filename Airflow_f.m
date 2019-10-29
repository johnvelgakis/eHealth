function varargout = Airflow_f(varargin)
% AIRFLOW_F MATLAB code for Airflow_f.fig
%      AIRFLOW_F, by itself, creates a new AIRFLOW_F or raises the existing
%      singleton*.
%
%      H = AIRFLOW_F returns the handle to a new AIRFLOW_F or the handle to
%      the existing singleton*.
%
%      AIRFLOW_F('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AIRFLOW_F.M with the given input arguments.
%
%      AIRFLOW_F('Property','Value',...) creates a new AIRFLOW_F or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Airflow_f_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Airflow_f_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Airflow_f

% Last Modified by GUIDE v2.5 02-May-2018 00:32:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Airflow_f_OpeningFcn, ...
                   'gui_OutputFcn',  @Airflow_f_OutputFcn, ...
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


% --- Executes just before Airflow_f is made visible.
function Airflow_f_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Airflow_f (see VARARGIN)

% Choose default command line output for Airflow_f
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Airflow_f wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Airflow_f_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in back_airflow.
function back_airflow_Callback(hObject, eventdata, handles)
% hObject    handle to back_airflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Health_monitor
close(Airflow_f)

% --- Executes on button press in start_airflow.
function start_airflow_Callback(hObject, eventdata, handles)
% hObject    handle to start_airflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
data=[];
s=serial('/dev/cu.usbmodem1411');
set(s,'BaudRate',9600);       %max baud rate for matlab
fopen(s);
for i=1:12000                  %5s=1000
    x=str2num(fgetl(s));
    data=[data,x];
end
fclose(s);
l=length(data);
if mod(l,2) == 1              %need to determine the parity of the collected data in order to 
    l=l-1;                    %distinguish the airflow and the ECG data. Odd data: ECG or EMG
end                           %Even data: Airflow.
l=0.5*l;                      %Divide by 2 because the data stream contains 2 data types so for
Air=0;                       %the time that will be used for the plot we have to divide it by 2.
for i=1:l
    Air(i)=data(2*i);    %Arduino measurement [1,1023] so we divide by 1023 which are the
end                                  %Arduino quantization units and also the range of the sensor is 0-5V
t=(1:l)/100;
figure
subplot(2,1,1)       % add first plot in 2 x 1 grid
plot(t,Air)
title('Noisy Respiration Signal');

plot(t,Air);
breath_time=1;
peak=[];
peak(breath_time)=0;
N=length(Air);
for i=200:N-1
    if Air(i)>Air(i-1) && Air(i)>Air(i+1) 
        peak(breath_time)=i;
        breath_time=breath_time+1;
    end
end
for i=1:N
    if Air(i)<10
        Air(i)=0;
    end
end
area=0;
for i=1:N
    area=area+Air(i);
end
subplot(2,1,2)       % add second plot in 2 x 1 grid
plot(t,Air) 
xlim(10,20)% plot using + markers
title('Respiration');





% --- Executes on button press in results_airflow.
function results_airflow_Callback(hObject, eventdata, handles)
% hObject    handle to results_airflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
