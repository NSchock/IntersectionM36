from itertools import *

# The main purpose of this file is to define the following variables:
# all_edges_1 = list of pairs {v1,v2} describing edges of boundary complex for $\widetilde{M}_1(3,6)$
# all_edges_0 = list of pairs {v1,v2} describing edges of boundary complex for $\overline{M}(3,6)$
# the vertices v1,v2 are represented as strings:
# 'D123' <-> $D_{123,456}$
# 'D12' <-> $D_{12,456}$
# 'D12_34_56' <-> $D_{12,34,56}$

# E,F,G correspond to boundary divisors e.g.:
# E123 <-> D_{123,456}, F12 <-> D_{12,3456}, G_{12,34,56} <-> D_{12,34,56}
# The notation E,F,G and the splitting into different types of edges is based
# on Speyer-Sturmfels "The Tropical Grassmannian"
labels = Set(range(1,7))
E = list(labels.subsets(3))
F = list(labels.subsets(2))
# We have to keep each vertex in G as a list of sets
# Converting to a set of sets removes the ordering, which matters for these
G = [[Set({1, 2}), Set({3, 4}), Set({5, 6})], [Set({3, 4}), Set({1, 2}), Set({5, 6})],
     [Set({1, 6}), Set({2, 3}), Set({4, 5})], [Set({2, 3}), Set({1, 6}), Set({4, 5})],
     [Set({1, 5}), Set({2, 3}), Set({4, 6})], [Set({2, 3}), Set({1, 5}), Set({4, 6})],
     [Set({1, 4}), Set({2, 3}), Set({5, 6})], [Set({2, 3}), Set({1, 4}), Set({5, 6})],
     [Set({1, 3}), Set({2, 4}), Set({5, 6})], [Set({2, 4}), Set({1, 3}), Set({5, 6})],
     [Set({1, 3}), Set({2, 5}), Set({4, 6})], [Set({2, 5}), Set({1, 3}), Set({4, 6})],
     [Set({1, 4}), Set({2, 5}), Set({3, 6})], [Set({2, 5}), Set({1, 4}), Set({3, 6})],
     [Set({1, 5}), Set({2, 4}), Set({3, 6})], [Set({2, 4}), Set({1, 5}), Set({3, 6})],
     [Set({1, 6}), Set({2, 4}), Set({3, 5})], [Set({2, 4}), Set({1, 6}), Set({3, 5})],
     [Set({1, 6}), Set({2, 5}), Set({3, 4})], [Set({2, 5}), Set({1, 6}), Set({3, 4})],
     [Set({1, 5}), Set({2, 6}), Set({3, 4})], [Set({2, 6}), Set({1, 5}), Set({3, 4})],
     [Set({1, 4}), Set({2, 6}), Set({3, 5})], [Set({2, 6}), Set({1, 4}), Set({3, 5})],
     [Set({1, 3}), Set({2, 6}), Set({4, 5})], [Set({2, 6}), Set({1, 3}), Set({4, 5})],
     [Set({1, 2}), Set({3, 6}), Set({4, 5})], [Set({3, 6}), Set({1, 2}), Set({4, 5})],
     [Set({1, 2}), Set({3, 5}), Set({4, 6})], [Set({3, 5}), Set({1, 2}), Set({4, 6})]]

# take a set like {1,2,3} or {1,2} and turn it into a string '123' or '12'
def get_label(d):
    return ''.join([str(x) for x in d])

# take a list like [{1,2},{3,4},{5,6}] and turn it into a string 12_34_56
def get_g_label(g):
    return get_label(g[0]) + '_' + get_label(g[1]) + '_' + get_label(g[2])

# edges_i corresponds to types of edges of boundary complex
EL = list(combinations(E,2))
edges_1 = [{'D' + get_label(s[0]),'D' + get_label(s[1])} for s in EL if (s[0].intersection(s[1])).cardinality() == 1]
edges_2 = [{'D' + get_label(s[0]),'D' + get_label(s[1])} for s in EL if (s[0].intersection(s[1])).cardinality() == 0]

FL = list(combinations(F,2))
edges_3 = [{'D' + get_label(s[0]), 'D' + get_label(s[1])} for s in FL if (s[0].intersection(s[1])).cardinality() == 0]

edges_4 = [{'D' + get_label(e1), 'D' + get_label(f1)} for e1 in E for f1 in F if (e1.intersection(f1)).cardinality() == 0]
edges_5 = [{'D' + get_label(e1), 'D' + get_label(f1)} for e1 in E for f1 in F if (e1.intersection(f1)).cardinality() == 2]

edges_6 = [{'D' + get_label(f), 'D' + get_g_label(g)} for f in F for g in G if f.intersection(g[0]).cardinality() == 2 or f.intersection(g[1]).cardinality() == 2 or f.intersection(g[2]).cardinality() == 2]

def eg_edge_valid(e,g):
    return (e.intersection(g[0]).cardinality() == 2 and e.intersection(g[1]).cardinality() == 1 and e.intersection(g[2]).cardinality() == 0) or\
           (e.intersection(g[1]).cardinality() == 2 and e.intersection(g[2]).cardinality() == 1 and e.intersection(g[0]).cardinality() == 0) or\
           (e.intersection(g[2]).cardinality() == 2 and e.intersection(g[0]).cardinality() == 1 and e.intersection(g[1]).cardinality() == 0)

edges_7 = [{'D' + get_label(e), 'D' + get_g_label(g)} for e in E for g in G if eg_edge_valid(e,g)]

# this is the 1-skeleton of the boundary complex of $\widetilde{M}_1(3,6)$
all_edges_1 = edges_1 + edges_2 + edges_3 + edges_4 + edges_5 + edges_6 + edges_7

# these are the edges removed to get the small resolution $\widetilde{M}_1(3,6)$
bad_edges = [('g_' + str([Set({1, 2}), Set({3, 4}), Set({5, 6})]), 'g_' + str([Set({3, 4}), Set({1, 2}), Set({5, 6})])),
             ('g_' + str([Set({1, 6}), Set({2, 3}), Set({4, 5})]), 'g_' + str([Set({2, 3}), Set({1, 6}), Set({4, 5})])),
             ('g_' + str([Set({1, 5}), Set({2, 3}), Set({4, 6})]), 'g_' + str([Set({2, 3}), Set({1, 5}), Set({4, 6})])),
             ('g_' + str([Set({1, 4}), Set({2, 3}), Set({5, 6})]), 'g_' + str([Set({2, 3}), Set({1, 4}), Set({5, 6})])),
             ('g_' + str([Set({1, 3}), Set({2, 4}), Set({5, 6})]), 'g_' + str([Set({2, 4}), Set({1, 3}), Set({5, 6})])),
             ('g_' + str([Set({1, 3}), Set({2, 5}), Set({4, 6})]), 'g_' + str([Set({2, 5}), Set({1, 3}), Set({4, 6})])),
             ('g_' + str([Set({1, 4}), Set({2, 5}), Set({3, 6})]), 'g_' + str([Set({2, 5}), Set({1, 4}), Set({3, 6})])),
             ('g_' + str([Set({1, 5}), Set({2, 4}), Set({3, 6})]), 'g_' + str([Set({2, 4}), Set({1, 5}), Set({3, 6})])),
             ('g_' + str([Set({1, 6}), Set({2, 4}), Set({3, 5})]), 'g_' + str([Set({2, 4}), Set({1, 6}), Set({3, 5})])),
             ('g_' + str([Set({1, 6}), Set({2, 5}), Set({3, 4})]), 'g_' + str([Set({2, 5}), Set({1, 6}), Set({3, 4})])),
             ('g_' + str([Set({1, 5}), Set({2, 6}), Set({3, 4})]), 'g_' + str([Set({2, 6}), Set({1, 5}), Set({3, 4})])),
             ('g_' + str([Set({1, 4}), Set({2, 6}), Set({3, 5})]), 'g_' + str([Set({2, 6}), Set({1, 4}), Set({3, 5})])),
             ('g_' + str([Set({1, 3}), Set({2, 6}), Set({4, 5})]), 'g_' + str([Set({2, 6}), Set({1, 3}), Set({4, 5})])),
             ('g_' + str([Set({1, 2}), Set({3, 6}), Set({4, 5})]), 'g_' + str([Set({3, 6}), Set({1, 2}), Set({4, 5})])),
             ('g_' + str([Set({1, 2}), Set({3, 5}), Set({4, 6})]), 'g_' + str([Set({3, 5}), Set({1, 2}), Set({4, 6})]))]

# this is the 1-skeleton of the boundary complex of $\overline{M}(3,6)$
all_edges_0 = all_edges_1 + bad_edges
