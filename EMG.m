function varargout = EMG(varargin)
%EMG MATLAB code file for EMG.fig
%      EMG, by itself, creates a new EMG or raises the existing
%      singleton*.
%
%      H = EMG returns the handle to a new EMG or the handle to
%      the existing singleton*.
%
%      EMG('Property','Value',...) creates a new EMG using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to EMG_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      EMG('CALLBACK') and EMG('CALLBACK',hObject,...) call the
%      local function named CALLBACK in EMG.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EMG

% Last Modified by GUIDE v2.5 13-Feb-2018 16:50:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EMG_OpeningFcn, ...
                   'gui_OutputFcn',  @EMG_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before EMG is made visible.
function EMG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for EMG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EMG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EMG_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartEMGButton.
function StartEMGButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartEMGButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
a = arduino('/dev/cu.usbmodem1411','Uno');
EMGlinepre=line(nan, nan, 'color', 'red');
EMGlinepost=line(nan, nan, 'color', 'green');
i=0;
fs=2000;
fc=1;
dt=1/fs;
while 1
    EMG=readVoltage(a,'A0');
    pause(0.1);
    x1=get(EMGlinepre, 'xData');
    y1=get(EMGlinepre, 'yData');
    x1=[x1, i];
    y1=[y1, EMG];
    x2=[x2, i];
    N=size(EMG,1);
    T=[0:N-1]'*dt;
    Rectified_EMG=abs(EMG);
    [b,a]=butter(1,fc*2/fs);
    y2=filtfilt(b,a,Rectified_EMG);
    set(EMGlinepre, 'xData', x1, 'yData', y1);
    set(EMGlinepost, 'xData', x2, 'yData', y2);
    i=i+1;
    pause(0.5);
end

% % Post-process and plot the data - Remove any excess zeros on the
% % logging variables.
% EMG = EMG(1:ii);
% t = t(1:ii);
% N=size(EMG,1);
% fs=2000;
% fc=1;
% dt=1/fs;
% T=[0:N-1]'*dt;
% Rectified_EMG=abs(EMG);
% % Plot temperature versus time
% figure
% [b,a]=butter(1,fc*2/fs);
% y=filtfilt(b,a,Rectified_EMG);
% plot(T,y)
% % plot(T,EMG,'-o')
% xlabel('Elapsed time [sec]')
% ylabel('Measured Voltage [Arduino Quantization Units]')
% title('Electromyogram')
% axes(handles.axesEMG)
% set(gca,'xlim',[t(1) t(ii)])
% handles.axes(handles.axesEMG);
% handles.plot = plot(handles.axesEMG);


% --- Executes on button press in BackEMGButton.
function BackEMGButton_Callback(hObject, eventdata, handles)
% hObject    handle to BackEMGButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
HomeScreen
close(EMG)
