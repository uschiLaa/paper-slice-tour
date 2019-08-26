import os


p = "./png/"
allNames = os.listdir(p)
allNamesUnique = []
for n in allNames:                                
  n = n[0:-8]
  if not n in allNamesUnique: allNamesUnique.append(n)

import moviepy.editor as mpy

for cn in allNamesUnique:                         
  cNames = []        
  for nn in allNames:                                 
    if cn in nn: cNames.append(nn)
  cNames = sorted(cNames)
  cPaths = [p+cName for cName in cNames]
  clip = mpy.ImageSequenceClip(cPaths, fps=6)
  clip.write_gif(cn+".gif", fps=6)
