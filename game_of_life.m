
function game_of_life(mat, number_generation, is_visual)

% �������� ������� ���������

if is_visual
    visual(mat);
    pause(5)
else
    warning('������������ �� ����������!')
end

% �������� ���� ���������
for i=1:number_generation
    
    % �������� ��������� ���������
    mat = getNewMat(mat);
    
    % ������������
    if is_visual
        visual(mat);
    end
    
end

end


function countMat = calcNeighbor(m)

% ������� �������� ���-�� �������. ������ ������ ������� countMat �������� m x m
% ��������� ����� �������

% �������������� ����� ������� � "������������ ������"
matInf = zeros(size(m)+2);

% �������������� ������� ����� �������
countMat = zeros(size(m,1), size(m,2));

% "��������" �������

% ��������� ������ �������� ������� ��� ���� ���� ������ (��� ���������)
matInf(2:end-1, 2:end-1) = m;
% ��������� ��� ������� ������ ������ ����
matInf(1, 2:end-1) = m(end, :);
% ��������� ����� ������� ���� ������ ����
matInf(end, 2:end-1) = m(1, :);
% ��������� ������ ������� ������� ����� ������ ����
matInf(2:end-1, 1) = m(:, end);
% ��������� ����� ������� ������� ������ ������ ���� 
matInf(2:end-1, end) = m(:, 1);

% "��������" ����

% ��������� ������ ������ ���� � ������� ����� ������ ����
matInf(1, 1) = m(end, end);
% ��������� ������ ����� ���� � ������� ������ ������ ����
matInf(1, end) = m(end, 1);
% ��������� ������� ������ ���� � ����� ������ ������ ����
matInf(end, 1) = m(1, end);
% ��������� ������� ����� ���� � ������ ������ ������ ����
matInf(end, end) = m(1, 1);

[xsize, ysize] = size(m);

% �������� ������� ���� ������ ������
for y = 2:ysize+1
    for x = 2:xsize+1
        % ������� ����� ������� ������ ������ (����� ����� ���������)
        countMat(x-1, y-1) = sum(sum(matInf(x-1:x+1, y-1:y+1))) - m(x-1, y-1);
    end
end

end

function matNew = getNewMat(m)

% ������� ��������� ����� �������. �� �������� ����

[xsize, ysize] = size(m);

% �������������� ����� �������
matNew = zeros(size(m));

% �������� ������� ���-�� ������� ������ ������
countMat = calcNeighbor(m);

idx = 0;

% ���� �� ������ ������ �� ����
for yInf = 2:ysize+1
    for xInf = 2:xsize+1
        
        idx = idx + 1;

        % �������� ����� ������
        count = countMat(idx);
        
        % ----- �������� �� �������� (����� ���������/�������� ����) -----
        
         % ������� 1: ���� ������ ������ � � ��� 3 �������, �� � ��� ����������� �����
        if (m(idx) == 0) && (count == 3)
            matNew(idx) = 1;
        end       
        
         % ������� 2: ���� ������ ���� � � ��� 2 ��� 3 ������, �� ���
        % �������� ����
        if (m(idx) == 1) && ((count == 2) || (count == 3))
            matNew(idx) = 1;
        end       
        
        % ������� 3: ���� ������ ���� � � ��� ������� ������ ����, �� ��� ������� ��
        % �����������
        if (m(idx) == 1) && (count < 2)
            matNew(idx) = 0;
        end

        % ������� 4: ���� ������ ���� � � ��� ������ 3 �������, �� ���
        % ������� �� ����������������
        if (m(idx) == 1) && (count > 3)
            matNew(idx) = 0;
        end
        
    end
end

end

function visual(mat)

% ������������

spy(mat, 'b', 8)
% disp(num2str([size(mat,1), size(mat, 2)]))
% axis off;
axis equal;
% ������ ���
xlim([0 size(mat,1)])
ylim([0 size(mat,2)])
title('Game of life')

drawnow

end
