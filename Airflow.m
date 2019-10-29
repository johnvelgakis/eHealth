function varargout = Airflow(varargin)
%AIRFLOW MATLAB code file for Airflow.fig
%      AIRFLOW, by itself, creates a new AIRFLOW or raises the existing
%      singleton*.
%
%      H = AIRFLOW returns the handle to a new AIRFLOW or the handle to
%      the existing singleton*.
%
%      AIRFLOW('Property','Value',...) creates a new AIRFLOW using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Airflow_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      AIRFLOW('CALLBACK') and AIRFLOW('CALLBACK',hObject,...) call the
%      local function named CALLBACK in AIRFLOW.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Airflow

% Last Modified by GUIDE v2.5 13-Feb-2018 16:50:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Airflow_OpeningFcn, ...
                   'gui_OutputFcn',  @Airflow_OutputFcn, ...
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


% --- Executes just before Airflow is made visible.
function Airflow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Airflow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Airflow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Airflow_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartAirflowButton.
function StartAirflowButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartAirflowButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Acquire and analyze data from a ECG sensor
clear all
%% Connect to Arduino

a = arduino('/dev/cu.usbmodem1411','Uno');

%% Record and plot 30 seconds of temperature data

ii = 0;
Airflow = zeros(1e5,1);
t = zeros(1e5,1);

tic
while toc < 30
    ii = ii + 1;
    v = readVoltage(a,'A1');
    
    % Get time since starting
    t(ii) = toc;
end

% Post-process and plot the data - Remove any excess zeros on the
% logging variables.

% Plot temperature versus time
plot(t,Airflow,'-o')
xlabel('Elapsed time [sec]')
ylabel('Breathing levels')
title('Respiration')
% set(gca,'xlim',[t(1) t(ii)])


% --- Executes on button press in BackAirflowButton.
function BackAirflowButton_Callback(hObject, eventdata, handles)
% hObject    handle to BackAirflowButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
HomeScreen
close(Airflow)
