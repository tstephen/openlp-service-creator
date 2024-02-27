import os
import xml.etree.ElementTree as ET

# Directory path
directory_path = "../html/song-lyrics/"

# XML processing instruction
xml_processing_instruction = '<?xml version="1.0" encoding="UTF-8"?>'
xsl_processing_instruction = '<?xml-stylesheet type="text/xsl" href="/xslt/openlp2html.xslt" ?>'

# Loop through each file in the directory
for filename in os.listdir(directory_path):
    if filename.endswith(".xml"):
        file_path = os.path.join(directory_path, filename)

        # Read the XML file
        with open(file_path, 'r') as xml_file:
            xml_content = xml_file.read()

        # Check if the processing instruction is already present
        if xml_content.startswith(f"{xml_processing_instruction}\n{xsl_processing_instruction}"):
            print(f"Processing instruction already present in {filename}")
        else:
            if xml_content.startswith(xml_processing_instruction) \
               or xml_content.startswith(xml_processing_instruction.replace('\"','\'')):
                #print("need to strip xml instruction")
                xml_content = xml_content[len(xml_processing_instruction):]
                #print(f"xml now starts {xml_content[0:50]}")

            # Add both processing instructions
            xml_content_with_pi = f"{xml_processing_instruction}\n{xsl_processing_instruction}\n{xml_content}"

            # Write the updated XML content back to the file
            with open(file_path, 'w') as xml_file:
                xml_file.write(xml_content_with_pi)

            print(f"Processing instruction added to {filename}")

