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

% Last Modified by GUIDE v2.5 27-May-2019 02:00:19

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

% assign the new value Data to the variable 'data' in Matlab WorkSpace
function setData(Data)
global data;
data = Data;
assignin('base', 'data', data);

% return the value stored in global variable 'data'
function Data = getData
global data;
Data = data;

% assign the new value Data to the variable 'selected' in Matlab WorkSpace
function setSelectedData(Data)
global selectedData;
selectedData = Data;
assignin('base', 'selected',selectedData);

% return the value stored in global variable 'selected'
function Data = getSelectedData
global selectedData;
Data = selectedData;

% set the title for this GUI and store the value in global variable
% 'titles' in Matlab WorkSpace
function setTitles(Titles)
global titles;
titles = Titles;
assignin('base', 'titles', Titles);

% return the name of the title of this GUI
function Titles = getTitles
global titles;
Titles = titles;

function setSelectedWindow(Window)
global selectedWindow;
selectedWindow = Window;
assignin('base', 'window', selectedWindow);

function Window = getSelectedWindow
global selectedWindow;
Window = selectedWindow;

function [f,P1] = FourierBerekening(input) 
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 473;             % Length of signal (at least this value)
t = (0:L-1)*T;        % Time vector
window = getSelectedWindow; % window function
S = cell2mat(input);
n = 2^nextpow2(L);
pad = zeros( n-L,1);
S = [S;pad];
S = S.* window;
X = S.';
Y = fft(X,n);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

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
set(handles.uipanel2,'visible','off')
set(handles.uipanel1,'visible','on')
set(handles.btnTimeDomain,'visible','off')


% --- Outputs from this function are returned to the command line.
function varargout = DigitalSignal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in btnSelectData.
% Opens the selected Excel file and run it through the function
% 'FileSelected'
function btnSelectData_Callback(hObject, eventdata, handles)
 [file, path, index] = uigetfile({'*.xlsx';});
    
    if isequal(file, 0)
        %disp('User canceled file selection \r\n');
    else
        %disp('User selected file \r\n');
        FileSelected(fullfile(path, file), hObject, eventdata, handles);
    end
    data = getSelectedData;
    axes(handles.axes10); plot(cell2mat(data(:,1)),'s');
    axes(handles.axes11); plot(cell2mat(data(:,7)),'s');
    axes(handles.axes12); plot(cell2mat(data(:,13)),'s');

% Gets the data from the specified Excel file
function FileSelected(fullpath, hObject, eventdata, handles)
[num, txt, raw] = xlsread(fullpath);

beginKolom = 3;
rij = 13;
data = raw(rij+3:end-1, beginKolom:end);
setData(data);
   
A = txt(13, :);
A = A(~cellfun(@isempty, A));
Q = split(A,":");
A = Q(:,:,2) ;
setTitles(A(1:22));
   
guidata(hObject, handles);
   
handles.listbox2.String = string(getTitles) ;
handles.popupmenu1.String = string(getTitles);
setSelectedWindow(int16.empty(3,0));


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


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
listBoxSelectedIndexes = handles.listbox2.Value;
pos = ((listBoxSelectedIndexes-1)*6)+1;
pos2 = pos+5;
data = getData;
a = data(:,pos:pos2);
b = data(:,(pos+22):(pos2 +22));
c = data(:,(pos+44):(pos2 +44));
C = [a b c];
setSelectedData(C);

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%View van paneel aanpassen-------------------
% --- Executes on button press in btnTimeDomain.
function btnTimeDomain_Callback(hObject, eventdata, handles)
set(handles.uipanel2,'visible','off')
set(handles.uipanel1,'visible','on')
set(handles.btnTimeDomain,'visible','off')
set(handles.btnFourier,'visible','on')

% --- Executes on button press in btnFourier.
function btnFourier_Callback(hObject, eventdata, handles)

set(handles.uipanel2,'visible','on')
set(handles.uipanel1,'visible','off')
set(handles.btnTimeDomain,'visible','on')
set(handles.btnFourier,'visible','off')
% --- Executes on button press in btnFourier.


% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)

data = getSelectedData;
analysisWindow = getSelectedWindow;

if ~isempty(analysisWindow)
    switch(get(eventdata.NewValue,'Tag'))
        case 'radiobutton1'
            [x0,P] = FourierBerekening(data(:,1));
            [y0,P1] = FourierBerekening(data(:,7));
            [z0,P2] = FourierBerekening(data(:,13));
        case 'radiobutton2'
            [x0,P] = FourierBerekening(data(:,2));
            [y0,P1] = FourierBerekening(data(:,8));
            [z0,P2] = FourierBerekening(data(:,14));
        case 'radiobutton3'
            [x0,P] = FourierBerekening(data(:,3));
            [y0,P1] = FourierBerekening(data(:,9));
            [z0,P2] = FourierBerekening(data(:,15));
        case 'radiobutton4'
            [x0,P] = FourierBerekening(data(:,4));
            [y0,P1] = FourierBerekening(data(:,10));
            [z0,P2] = FourierBerekening(data(:,16));
        case 'radiobutton5'
            [x0,P] = FourierBerekening(data(:,5));
            [y0,P1] = FourierBerekening(data(:,11));
            [z0,P2] = FourierBerekening(data(:,17));
        case 'radiobutton6'
            [x0,P] = FourierBerekening(data(:,6));
            [y0,P1] = FourierBerekening(data(:,12));
            [z0,P2] = FourierBerekening(data(:,18));
    end
        axes(handles.axes2); plot(x0,P, 's');
        axes(handles.axes3); plot(y0,P1, 's')
        axes(handles.axes4); plot(z0,P2, 's')
else 
    disp('Selecteer eerst een window-functie');
end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getSelectedData;

switch(get(eventdata.NewValue,'Tag'))
    case 'radiobutton7'
        axes(handles.axes10); plot(cell2mat(data(:,1)),'s')
        axes(handles.axes11); plot(cell2mat(data(:,7)),'s')
        axes(handles.axes12); plot(cell2mat(data(:,13)),'s')
    case 'radiobutton8'
        axes(handles.axes10); plot(cell2mat(data(:,2)),'s');
        axes(handles.axes11); plot(cell2mat(data(:,8)),'s');
        axes(handles.axes12); plot(cell2mat(data(:,14)),'s');
    case 'radiobutton9'
        axes(handles.axes10); plot(cell2mat(data(:,3)),'s');
        axes(handles.axes11); plot(cell2mat(data(:,9)),'s');
        axes(handles.axes12); plot(cell2mat(data(:,15)),'s');
    case 'radiobutton10'
        axes(handles.axes10); plot(cell2mat(data(:,4)),'s');
        axes(handles.axes11); plot(cell2mat(data(:,10)),'s');
        axes(handles.axes12); plot(cell2mat(data(:,16)),'s');
    case 'radiobutton11'
        axes(handles.axes10); plot(cell2mat(data(:,5)),'s');
        axes(handles.axes11); plot(cell2mat(data(:,11)),'s');
        axes(handles.axes12); plot(cell2mat(data(:,17)),'s');
    case 'radiobutton12'
        axes(handles.axes10); plot(cell2mat(data(:,6)),'s');
        axes(handles.axes11); plot(cell2mat(data(:,12)),'s');
        axes(handles.axes12); plot(cell2mat(data(:,18)),'s');
end



% --- Executes on button press in btnHann.
function btnHann_Callback(hObject, eventdata, handles)
% hObject    handle to btnHann (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('Wordt de hann funtion opgeroepen?');
hannWindow = hann(513);
setSelectedWindow(hannWindow(1:512));


% --- Executes on button press in btnBlackman.
function btnBlackman_Callback(hObject, eventdata, handles)
% hObject    handle to btnBlackman (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Wordt de blackman funtion opgeroepen?');
blackmanWindow = blackman(513);
setSelectedWindow(blackmanWindow(1:512));


% --- Executes on button press in btnNuttall.
function btnNuttall_Callback(hObject, eventdata, handles)
% hObject    handle to btnNuttall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Wordt de nuttall funtion opgeroepen?');
nuttallWindow = nuttallwin(513);
setSelectedWindow(nuttallWindow(1:512));


% --- Executes on button press in btnFlattop.
function btnFlattop_Callback(hObject, eventdata, handles)
% hObject    handle to btnFlattop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Wordt de flattop funtion opgeroepen?');
flattopWindow = flattopwin(513);
setSelectedWindow(flattopWindow(1:512));