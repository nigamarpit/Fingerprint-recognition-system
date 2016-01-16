function template=fingerTemplateRead
%dialog for opening fingerprint files

[templatefile , pathname]= uigetfile('*.dat','Open An Fingerprint template file'); 
if templatefile ~= 0 
cd(pathname);
template=load(char(templatefile));
end;
