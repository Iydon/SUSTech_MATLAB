function [result_lores] = PCA(lores)
    % PCA dimensionality reduction
    % lores ��������ʾԭʼ���ݵ�ά���� ������ʾ���ݵĸ���
    % ����ֱ��ʹ��build-in����pca
    C = double(lores * lores');
    [V, D] = eig(C);
    D = diag(D);                % perform PCA on features matrix 
    D = cumsum(D) / sum(D);
    k = find(D >= 1e-3, 1);     % ignore 0.1% energy
    V_pca = V(:, k:end);        % choose the largest eigenvectors' projection
    result_lores = V_pca' * lores;
end
