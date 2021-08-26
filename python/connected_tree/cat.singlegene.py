import click
@click.command()
@click.option('--infile')
@click.option('--out')
def cat(infile,out):
    seq ={}
    raw = open(infile,'r')
    outfile = open(out,'w')
    name = 'delete'
    for line in raw:
        if line.startswith('>'):
            line = line.split('_')[0]
            if line == name:
                pass
            else:
                name = line.strip()
                seq[name] = ''
        else:
            seq[name] += line.replace('\n','')
    for k, v in seq.items():
        outfile.write(k+'\n'+v+'\n')
    outfile.close()
if __name__ == '__main__':
    cat()   