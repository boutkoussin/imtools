%% EDITEMPLATE - Template documention edition.
%
%% Description
% Create and edit a new function with standard documentation template. Call
% |EDITEMPLATE| alone (no arguments) to see the current template documentation.
%
%% Syntax
%       EDITEMPLATE();
%       EDITEMPLATE(filename);
%       f = EDITEMPLATE(filename, code);
%
%% Inputs
% *|filename|* : string storing file/function name to be edited; if no argument,
%     or an empty string are passed, the template documentation is simply 
%     displayed on the standard output (screen), no file creation/edition is
%     performed.
%
% *|code|* : string storing some piece of code to be inserted in the body of
%     the function.
%
%% Output
% *|f|* : output template file ID.
%
%% See also
% Related:
% <matlab:webpub(whichpath('edit')) |EDIT|>.

%% Function implementation
function fID = editemplate(filename, code)

if nargin==0,  filename = ''; end % default empty string
    
%%
% define the function name
funcname = filename;
% basename
if ~isempty(filename)
    i = strfind(filename,'/');
    if ~isempty(i),  funcname = funcname(i(end)+1:end);  end
    
    if ~strcmpi(filename((end-1):end), '.m'),  filename = [filename '.m'];
    else                                       funcname = funcname(1:end-2);
    end
end

%%
% define the template to insert
Template = ['%%%% ' upper(funcname) '\n'...
    '%%\n' ...
    '%%%% Description\n' ...
    '%% \n' ...
    '%%\n' ...
    '%%%% Algorithm\n' ...
    '%% #\n' ...
    '%%\n' ...
    '%%%% Syntax\n' ...
    '%%       [] = ' upper(funcname) '();\n' ...
    '%%\n' ...
    '%%%% Inputs\n'...
    '%% *||* : \n' ...
    '%%     \n' ...
    '%%\n' ...
    '%%%% Property [propertyname  propertyvalues]\n' ...
    '%% *|''|* : \n' ...
    '%%     \n' ...
    '%%\n' ...
    '%%%% Outputs\n' ...
    '%% *||* : \n' ...
    '%%     \n' ...
    '%%\n' ...
    '%%%% Remarks\n' ...
    '%% * \n' ...
    '%% \n' ...
    '%%\n' ...
    '%%%% References\n' ...
    '%% []  \n' ...
    '%%      <>\n' ...
    '%%\n' ...
    '%%%% Credit\n' ...
    '%% <mailto:jacopo.grazzini@jrc.ec.europa.eu J.Grazzini> (IES/JRC)\n' ...
    '%%\n' ...
    '%%%% See also\n' ...
    '%% Related:\n' ...
    '%% <.html ||>\n' ...
    '%% <../..//html/.html ||>\n' ...
    '%% <matlab:webpub(whichpath('''')) ||>\n' ...
    '%% Called:\n' ...
    '%% <.html ||>\n' ...
    '%% <../..//html/.html ||>\n' ...
    '%% <matlab:webpub(whichpath('''')) ||>\n' ...
    '\n' ...
    '%%%% Function implementation\n' ...
    '%%--------------------------------------------------------------------------\n' ...
    'function [] = ' funcname '()\n' ...
    '\n'];
% [s, r] = system('net user %username% /domain');
% ['%% Username: ' strrep(char(System.Security.Principal.WindowsIdentity.GetCurrent.Name), '\', '\\') '\n'];
% ['%% Display Name: ' strtrim(r(strfind(r, 'Full Name')+length('Full Name'):strfind(r, 'Comment')-1)) '\n'];
% ['%% Computer Name: ' getenv('computername') '\n'];
% ['%% Windows: ' char(System.Environment.OSVersion.ToString()) '\n'];
% ['%% Date: ' datestr(now) '\n\n\n'];

% append code if given
if nargin == 2
    if iscellstr(code)
        code = char(cellfun(@(x) [x '\n'], code, 'UniformOutput', false));
        code = reshape(code, [1 numel(code)]);
    end
    Template = [Template ...
        code ...
        '\n'];  
end

Template = [Template ...
    'end %% end of ' funcname '\n' ...
    '\n' ...
    '\n' ...
    '%%%% Subfunctions\n' ...
    '\n' ...
    '%%%%\n' ...
    '%% || - \n' ...
    '%%--------------------------------------------------------------------------\n' ...
    '\n' ...
    ];

%%
% display or write/edit the template function

if isempty(filename) || exist(filename, 'file')
    
    if exist(filename, 'file')
        warning('editemplate:inputwarning', 'file already exists - simply edit');
    end
    fprintf(1,Template); % fID=1: standard output
    
else
    try
        fID = fopen(filename,'w');
        fprintf(fID, Template);
    catch                                                              %#ok
       disp('ougl')
       fclose(fID);
        delete(fID);
        error('editemplate:openwarning', 'could not write file');
    end
    
    try
        edit(filename);
    catch                                                                  %#ok
        error('editemplate:openwarning', 'could not open file');
    end
end

end %  end of editemplate

