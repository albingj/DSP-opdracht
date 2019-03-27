function varargout = DigitalSignal(varargin)
% DIGITALSIGNAL MATLAB code for DigitalSignal.fig
%      DIGITALSIGNAL, by itself, creates a new DIGITALSIGNAL or raises the existing
%      singleton*.
%
%      H = DIGITALSIGNAL returns the handle to a new DIGITALSIGNAL or the handle to
%      the existing singleton*.
%
%      DIGITALSIGNAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIGITALSIGNAL.M with the given input arguments.
%
%      DIGITALSIGNAL('Property','Value',...) creates a new DIGITALSIGNAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DigitalSignal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DigitalSignal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DigitalSignal

% Last Modified by GUIDE v2.5 20-Mar-2019 15:23:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DigitalSignal_OpeningFcn, ...
                   'gui_OutputFcn',  @DigitalSignal_OutputFcn, ...
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


% --- Executes just before DigitalSignal is made visible.
function DigitalSignal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DigitalSignal (see VARARGIN)

% Choose default command line output for DigitalSignal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DigitalSignal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DigitalSignal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in btnSelectData.
function btnSelectData_Callback(hObject, eventdata, handles)
t=0;
if(t<1)
    t=1;
    [file, path, index] = uigetfile({'*.xlsx';});
    if isequal(file, 0)
        disp('User delected cancel');
    else
        disp(['User selected', fullfile(path, file)]);
    end
    t=0;
    num = xlsread(fullfile(path, file), -1);
end

%u = readtable(num);
%vars = {'Age','Systolic'};
%https://nl.mathworks.com/help/matlab/ref/uitable.html?searchHighlight=uitable&s_tid=doc_srchtitle
set(handles.uitable1, 'data', num);
plot([1 2 3],[2 4 6]);


% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txtColumn_Callback(hObject, eventdata, handles)
% hObject    handle to txtColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtColumn as text
%        str2double(get(hObject,'String')) returns contents of txtColumn as a double


% --- Executes during object creation, after setting all properties.
function txtColumn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
