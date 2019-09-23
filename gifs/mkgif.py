import os


p = "./png/"
names = os.listdir(p)

import moviepy.editor as mpy

for cn in names:                         
  cNames = os.listdir(p+cn)
#  for nn in os.listdir(p+cn):
#    cNames.append(nn.split(".")[0])
  cNames = sorted(cNames)
  cPaths = [p+cn+"/"+cName for cName in cNames]
  clip = mpy.ImageSequenceClip(cPaths, fps=6)
  clip.write_gif(cn+".gif", fps=6)
