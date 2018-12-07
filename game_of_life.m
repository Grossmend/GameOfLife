
function game_of_life

clear
close all
clc

% ������ �������
xCount = 100;
yCount = 100;

% �������������� ������
mat = zeros(xCount, yCount);
% cells = vec2mat((1:1:100), 10, 10);
% ���������� ��������� �����
idx = randsample(numel(mat), numel(mat)/10);
mat(idx) = 1;
showCells(mat);

% Rules
for i=1:1000
    % ��������� ���������
    cellsNew = findNeighbor(mat);
    % ����������
    mat = cellsNew;
    % ������������
    showCells(mat);
end

end


function matNew = findNeighbor(m)

% ���������� ������

% �������������� ����� ��������� � ������������ ������
matInf = zeros(size(m)+2);

% ��������� ������ ��������� ������� ��� ���� ���� ������
matInf(2:end-1, 2:end-1) = m;
% ��������� ��� ������� ������ ������ ����
matInf(1, 2:end-1) = m(end, :);
% ��������� ����� ������� ���� ������ ����
matInf(end, 2:end-1) = m(1, :);
% ��������� ������ ������� ������� ����� ������ ����
matInf(2:end-1, 1) = m(:, end);
% ��������� ����� ������� ������� ������ ������ ���� 
matInf(2:end-1, end) = m(:, 1);

% ���������� �����

% ��������� ������ ������ ���� � ������� ����� ������ ����
matInf(1, 1) = m(end, end);
% ��������� ������ ����� ���� � ������� ������ ������ ����
matInf(1, end) = m(end, 1);
% ��������� ������� ������ ���� � ����� ������ ������ ����
matInf(end, 1) = m(1, end);
% ��������� ������� ����� ���� � ������ ������ ������ ����
matInf(end, end) = m(1, 1);

[nelx, nely] = size(m);

matNew = zeros(size(m));

% ���� �� ������ ������ �� ����
% idx = 0;

for yInf = 2:nely+1
    for xInf = 2:nelx+1
        
        % idx = idx + 1;
        idx = sub2ind([nelx,nely], xInf-1, yInf-1);
        
        % disp(num2str([idx, idx2]))
        
        % ������� ����� ������� ������ ������ (����� ����� ���������)
        count = sum(sum(matInf(xInf-1:xInf+1, yInf-1:yInf+1))) - m(idx);
        
        % ������� 1: ���� ������ ���� � � ��� ������� ������ ����, �� ��� ������� ��
        % �����������
        if (m(idx) == 1) && (count < 2)
            matNew(idx) = 0;
        end
        
        % ������� 2: ���� ������ ���� � � ��� 2 ��� 3 ������, �� ���
        % �������� ����
        if (m(idx) == 1) && ((count == 2) || (count == 3))
            matNew(idx) = 1;
        end
        
        % ������� 3: ���� ������ ���� � � ��� ������ 3 �������, �� ���
        % ������� �� ����������������
        if (m(idx) == 1) && (count > 3)
            matNew(idx) = 0;
        end
        
        % ������� 4: ���� ������ ������ � � ��� 3 �������, �� � ��� ����������� �����
        if (m(idx) == 0) && (count == 3)
            matNew(idx) = 1;
        end
        
    end
end

end

function showCells(cells)

% ������������
imagesc(cells); caxis([0 1]);
colormap(flipud(gray));
axis off;
axis equal;
drawnow

end


