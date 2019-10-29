function varargout = HomeScreen(varargin)
%HOMESCREEN MATLAB code file for HomeScreen.fig
%      HOMESCREEN, by itself, creates a new HOMESCREEN or raises the existing
%      singleton*.
%%
% 
%  
% 
%
%      H = HOMESCREEN returns the handle to a new HOMESCREEN or the handle to
%      the existing singleton*.
%
%      HOMESCREEN('Property','Value',...) creates a new HOMESCREEN using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to HomeScreen_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      HOMESCREEN('CALLBACK') and HOMESCREEN('CALLBACK',hObject,...) call the
%      local function named CALLBACK in HOMESCREEN.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HomeScreen

% Last Modified by GUIDE v2.5 13-Feb-2018 16:50:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HomeScreen_OpeningFcn, ...
                   'gui_OutputFcn',  @HomeScreen_OutputFcn, ...
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


% --- Executes just before HomeScreen is made visible.
function HomeScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for HomeScreen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HomeScreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HomeScreen_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ECGHomeScreen.
function ECGHomeScreen_Callback(hObject, eventdata, handles)
% hObject    handle to ECGHomeScreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ECG
close(HomeScreen)

% --- Executes on button press in EMGHomeScreen.
function EMGHomeScreen_Callback(hObject, eventdata, handles)
% hObject    handle to EMGHomeScreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EMG
close(HomeScreen)

% --- Executes on button press in AirflowHomeScreen.
function AirflowHomeScreen_Callback(hObject, eventdata, handles)
% hObject    handle to AirflowHomeScreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Airflow
close(HomeScreen)

% --- Executes on button press in SettingsHomeScreen.
function SettingsHomeScreen_Callback(hObject, eventdata, handles)
% hObject    handle to SettingsHomeScreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Settings
close(HomeScreen)
