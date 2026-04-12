-- CALCUL DES RACINES de E8 :

roots = {}

-- Racines de type A
for i = 1, 8 do
    for j = i+1, 8 do
        for s1 = -2, 2, 4 do
            for s2 = -2, 2, 4 do
                local v = {0,0,0,0,0,0,0,0}
                v[i] = s1
                v[j] = s2
                roots[#roots+1] = v
            end
        end
    end
end

-- Racines de type B
for mask = 0, 255 do
    local v = {}
    local count_plus = 0

    for i = 1, 8 do
        local bit = math.floor(mask / 2^(i-1)) % 2
        if bit == 1 then
            v[i] = 1
            count_plus = count_plus + 1
        else
            v[i] = -1
        end
    end

    if count_plus % 2 == 0 then
        roots[#roots+1] = v
    end
end

-- CALCUL DES ARETES

edges = {}

function sqdist(v,w)
	local r = 0
	for i=1,8 do 
		r = r + (v[i] - w[i])^2
	end
	return r
end

for i=1,#roots do
	for j=i+1,#roots do
		if sqdist(roots[i],roots[j]) == 8 then
			edges[#edges+1] = {i,j}
		end
	end
end

-- CACLUL DES PROJECTIONS

projection_matrix = {
  {0.5801, 0.2403, 0.4247, 0.0000, -0.5801, 0.2403, 0.00000, 0.1759},
  {0.5801, 0.2403, 0.0000, 0.1759, 0.5801, -0.2403, -0.4247, 0.0000}
}

function project(roots,matrix)
	local projections = {}
	for i = 1, #roots do
	    local v = roots[i]
	    local y1 = 0
	    local y2 = 0
	    for j = 1, 8 do
	        y1 = y1 + matrix[1][j] * v[j]
	        y2 = y2 + matrix[2][j] * v[j]
	    end
	    projections[i] = {y1, y2}
	end
	return projections
end


roots_projections = project(roots,projection_matrix)
